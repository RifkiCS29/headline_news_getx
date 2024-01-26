import 'package:get/get.dart';
import 'package:headline_news_getx/domain/repositories/article_repository.dart';

class GetBookmarkStatus {
  final ArticleRepository repository = Get.find<ArticleRepository>();

  Future<bool> execute(String url) async {
    return repository.isAddedToBookmarkArticle(url);
  }
}
