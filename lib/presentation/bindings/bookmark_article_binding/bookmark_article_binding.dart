import 'package:get/get.dart';
import 'package:headline_news_getx/presentation/controllers/bookmark_article_controller/bookmark_article_controller.dart';

class BookmarkArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookmarkArticleController>(() => BookmarkArticleController());
  }
}
