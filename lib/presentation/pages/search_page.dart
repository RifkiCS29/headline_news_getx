import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/common/config.dart';
import 'package:headline_news_getx/common/state_enum.dart';
import 'package:headline_news_getx/common/theme.dart';
import 'package:headline_news_getx/injection.dart';
import 'package:headline_news_getx/presentation/controllers/search_article_controller/search_article_controller.dart';
import 'package:headline_news_getx/presentation/widgets/initial.dart';
import 'package:headline_news_getx/presentation/widgets/loading_article_list.dart';
import 'package:headline_news_getx/presentation/widgets/nodata.dart';
import 'package:headline_news_getx/presentation/widgets/error.dart';
import 'package:headline_news_getx/presentation/widgets/widgets.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:rxdart/rxdart.dart';

final _querySubject = BehaviorSubject<String>();
late StreamSubscription<String> _querySubscription;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  int currentPage = 1;
  int totalPage = 0;

  final SearchArticleController _searchArticleController = Get.put(
    SearchArticleController(locator()),
  );

  @override
  void initState() {
    super.initState();
    _querySubscription =
        _querySubject.debounceTime(const Duration(seconds: 1)).listen((query) {
      _searchArticleController.onQueryChanged(query);
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              key: const Key('edtSearch'),
              onChanged: (query) {
                _querySubject.add(query);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                labelStyle: TextStyle(
                  color: kPrimaryColor,
                ),
                prefixIcon: Icon(Icons.search, color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(24),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kGreyColor),
                  borderRadius: BorderRadius.circular(24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Search Result',
              style: blackTextStyle,
            ),
          ),
          Flexible(
            child: Obx(
              () {
                final state = _searchArticleController.state.value;
                if (state == RequestState.initial) {
                  return const Center(
                    child: Initial(message: 'Search the News'),
                  );
                } else if (state == RequestState.loading) {
                  return const LoadingArticleList();
                } else if (state == RequestState.loaded) {
                  currentPage = _searchArticleController.currentPage.value;
                  final result = _searchArticleController.articles;
                  totalPage =
                      (_searchArticleController.totalResult.value / pageSize)
                          .ceil();
                  return LazyLoadScrollView(
                    onEndOfPage: () {
                      if ((currentPage <= 5) && (currentPage < totalPage)) {
                        _searchArticleController.onNextPage(
                          _querySubject.value,
                          currentPage,
                        );
                      }
                    },
                    scrollOffset: 150,
                    child: ListView.builder(
                      key: const Key('search_item'),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemBuilder: (context, index) {
                        final article = result[index];
                        return ArticleList(article: article);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state == RequestState.empty) {
                  return Center(
                    child:
                        NoData(message: _searchArticleController.message.value),
                  );
                } else if (state == RequestState.error) {
                  return Center(
                    child:
                        Error(message: _searchArticleController.message.value),
                  );
                } else {
                  return Center(
                    child: Text(state.runtimeType.toString()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _querySubscription.cancel();
    super.dispose();
  }
}
