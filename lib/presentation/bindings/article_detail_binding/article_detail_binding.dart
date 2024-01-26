import 'package:get/get.dart';
import 'package:headline_news_getx/presentation/controllers/article_detail_controller/article_detail_controller.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleDetailController>(() => ArticleDetailController());
  }
}
