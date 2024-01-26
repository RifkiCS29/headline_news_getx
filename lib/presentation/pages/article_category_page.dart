import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/common/state_enum.dart';
import 'package:headline_news_getx/common/string_extensions.dart';
import 'package:headline_news_getx/common/theme.dart';
import 'package:headline_news_getx/injection.dart';
import 'package:headline_news_getx/presentation/controllers/article_category_controller/article_category_controller.dart';
import 'package:headline_news_getx/presentation/widgets/loading_article_list.dart';
import 'package:headline_news_getx/presentation/widgets/widgets.dart';

class ArticleCategoryPage extends StatelessWidget {
  const ArticleCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String category = Get.arguments as String;

    return GetBuilder<ArticleCategoryController>(
      init: ArticleCategoryController(locator())
        ..fetchArticleCategory(category),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          elevation: 0.0,
          title: Text(
            category.toCapitalized(),
            style:
                primaryTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
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
            final state = controller.articleCategoryState.value;
            final articles = controller.dataArticleCategory;
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
                child: Text(controller.messageArticleCategory.value),
              );
            } else if (state == RequestState.error) {
              return Center(
                child: Text(controller.messageArticleCategory.value),
              );
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
