import 'package:get/get.dart';
import 'package:headline_news_getx/presentation/controllers/search_article_controller/search_article_controller.dart';

class SearchArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchArticleController>(() => SearchArticleController());
  }
}
