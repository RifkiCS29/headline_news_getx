import 'package:get/get.dart';
import 'package:headline_news_getx/common/state_enum.dart';
import 'package:headline_news_getx/domain/entities/article.dart';
import 'package:headline_news_getx/domain/usecases/get_article_category.dart';

class ArticleCategoryController extends GetxController {
  final GetArticleCategory _getArticleCategory = Get.find<GetArticleCategory>();

  RxList<Article> dataArticleCategory = <Article>[].obs;
  Rx<RequestState> articleCategoryState =
      Rx<RequestState>(RequestState.loading);
  Rx<String> messageArticleCategory = Rx<String>('');

  void fetchArticleCategory(String category) async {
    articleCategoryState.value = RequestState.loading;

    final result = await _getArticleCategory.execute(category);

    result.fold(
      (failure) {
        articleCategoryState.value = RequestState.error;
        messageArticleCategory.value = failure.message;
      },
      (articleData) {
        articleCategoryState.value = RequestState.loaded;
        dataArticleCategory.value = articleData;
        if (articleData.isEmpty) {
          articleCategoryState.value = RequestState.empty;
        }
      },
    );
  }
}
