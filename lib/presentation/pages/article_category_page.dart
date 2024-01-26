import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/common/state_enum.dart';
import 'package:headline_news_getx/common/string_extensions.dart';
import 'package:headline_news_getx/common/theme.dart';
import 'package:headline_news_getx/presentation/controllers/article_category_controller/article_category_controller.dart';
import 'package:headline_news_getx/presentation/widgets/loading_article_list.dart';
import 'package:headline_news_getx/presentation/widgets/widgets.dart';

final _controller = Get.put(ArticleCategoryController());

class ArticleCategoryPage extends StatelessWidget {
  final String category = Get.arguments as String;

  ArticleCategoryPage({Key? key}) : super(key: key) {
    _controller.fetchArticleCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0.0,
        title: Text(
          category.toCapitalized(),
          style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: kPrimaryColor,
        ),
      ),
      body: Obx(
        () {
          final state = _controller.articleCategoryState.value;
          final articles = _controller.dataArticleCategory;
          if (state == RequestState.loading) {
            return const Padding(
              padding: EdgeInsets.only(top: 8),
              child: LoadingArticleList(),
            );
          } else if (state == RequestState.loaded) {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  var article = articles[index];
                  return ArticleList(article: article);
                },
              ),
            );
          } else if (state == RequestState.empty) {
            return Center(
              child: Text(_controller.messageArticleCategory.value),
            );
          } else if (state == RequestState.error) {
            return Center(
              child: Text(_controller.messageArticleCategory.value),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }
}
