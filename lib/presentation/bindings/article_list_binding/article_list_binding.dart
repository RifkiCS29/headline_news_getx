import 'package:get/get.dart';
import 'package:headline_news_getx/presentation/controllers/article_list_controller/article_list_controller.dart';

class ArticleListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleListController>(() => ArticleListController());
  }
}
