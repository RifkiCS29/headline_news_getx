import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/common/state_enum.dart';
import 'package:headline_news_getx/common/theme.dart';
import 'package:headline_news_getx/presentation/controllers/article_list_controller/article_list_controller.dart';
import 'package:headline_news_getx/presentation/widgets/loading_article_card.dart';
import 'package:headline_news_getx/presentation/widgets/loading_article_list.dart';
import 'package:headline_news_getx/presentation/widgets/widgets.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GetBuilder<ArticleListController>(
        init: ArticleListController(),
        builder: (articleController) => RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            articleController.fetchTopHeadlineArticles();
            articleController.fetchHeadlineBusinessArticles();
          },
          child: ListView(
            children: [
              _listTopHeadlineArticles(articleController),
              const SizedBox(height: 8),
              _listCategory(),
              const SizedBox(height: 8),
              _listHeadlineBusinessArticles(articleController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTopHeadlineArticles(ArticleListController articleController) {
    return Container(
      height: 230,
      width: double.infinity,
      color: kWhiteColor,
      child: Obx(
        () {
          final state = articleController.topHeadlineState.value;
          final data = articleController.dataTopHeadline;
          if (state == RequestState.loading) {
            return const LoadingArticleCard();
          } else if (state == RequestState.loaded) {
            return ListView.builder(
              key: const Key('headline_news_item'),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                var article = data[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    (article == data.first) ? 24 : 6,
                    8,
                    (article == data.last) ? 24 : 6,
                    8,
                  ),
                  child: TopHeadlineArticleCard(article: article),
                );
              },
            );
          } else if (state == RequestState.empty) {
            return const Center(child: Text('Empty Article'));
          } else if (state == RequestState.error) {
            return Center(
              child: Text(
                articleController.messageTopHeadline.value,
              ),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }

  Widget _listCategory() {
    return Container(
      height: 120,
      width: double.infinity,
      color: kWhiteColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: ListView(
          key: const Key('article_category'),
          scrollDirection: Axis.horizontal,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed('/article-category', arguments: 'sport'),
              child: const CategoryCard('Sport', 'assets/sports.png'),
            ),
            GestureDetector(
              onTap: () =>
                  Get.toNamed('/article-category', arguments: 'business'),
              child: const CategoryCard('Business', 'assets/business.png'),
            ),
            GestureDetector(
              onTap: () =>
                  Get.toNamed('/article-category', arguments: 'health'),
              child: const CategoryCard('Health', 'assets/health.png'),
            ),
            GestureDetector(
              onTap: () =>
                  Get.toNamed('/article-category', arguments: 'science'),
              child: const CategoryCard('Science', 'assets/science.png'),
            ),
            GestureDetector(
              onTap: () =>
                  Get.toNamed('/article-category', arguments: 'technology'),
              child: const CategoryCard('Technology', 'assets/technology.png'),
            ),
            GestureDetector(
              onTap: () =>
                  Get.toNamed('/article-category', arguments: 'entertainment'),
              child: const CategoryCard(
                'Entertainment',
                'assets/entertainment.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listHeadlineBusinessArticles(
    ArticleListController articleController,
  ) {
    return Obx(
      () {
        final state = articleController.businessHeadlineState.value;
        final data = articleController.dataBusinessHeadline.value;
        if (state == RequestState.loading) {
          return Container(
            color: kWhiteColor,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8),
            child: const LoadingArticleList(),
          );
        } else if (state == RequestState.loaded) {
          return Container(
            color: kWhiteColor,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8),
            child: ListView.builder(
              key: const Key('headline_business_item'),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data?.length,
              itemBuilder: (context, index) {
                var article = data?[index];
                return ArticleList(article: article!);
              },
            ),
          );
        } else if (state == RequestState.empty) {
          return const Center(child: Text('Empty Article'));
        } else if (state == RequestState.error) {
          return Center(
            child: Text(
              articleController.messageBusinessHeadline.value,
            ),
          );
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
