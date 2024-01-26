import 'package:get/get.dart';
import 'package:headline_news_getx/presentation/controllers/article_category_controller/article_category_controller.dart';

class ArticleCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleCategoryController>(() => ArticleCategoryController());
  }
}
