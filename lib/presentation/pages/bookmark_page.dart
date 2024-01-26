import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/common/state_enum.dart';
import 'package:headline_news_getx/common/utils.dart';
import 'package:headline_news_getx/domain/entities/article.dart';
import 'package:headline_news_getx/injection.dart';
import 'package:headline_news_getx/presentation/controllers/bookmark_article_controller/bookmark_article_controller.dart';
import 'package:headline_news_getx/presentation/widgets/loading_article_list.dart';
import 'package:headline_news_getx/presentation/widgets/widgets.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> with RouteAware {
  final BookmarkArticleController _bookmarkArticleController = Get.put(
    BookmarkArticleController(locator()),
  );

  @override
  void initState() {
    super.initState();
    _bookmarkArticleController.fetchBookmarkArticles();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    _bookmarkArticleController.fetchBookmarkArticles();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Obx(
        () {
          final state = _bookmarkArticleController.bookmarkArticleState.value;
          final articles = _bookmarkArticleController.dataBookmark.value;
          if (state == RequestState.loading) {
            return const Padding(
              padding: EdgeInsets.only(top: 8),
              child: LoadingArticleList(),
            );
          } else if (state == RequestState.loaded) {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ListView.builder(
                key: const Key('bookmark_item'),
                shrinkWrap: true,
                itemCount: articles?.length,
                itemBuilder: (context, index) {
                  var article = articles?[index];
                  return ArticleList(article: article ?? Article());
                },
              ),
            );
          } else if (state == RequestState.empty) {
            return const Center(child: Text('Empty Bookmark'));
          } else if (state == RequestState.error) {
            return Center(
              child: Text(_bookmarkArticleController.message.value),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
