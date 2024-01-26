import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/common/failure.dart';
import 'package:headline_news_getx/domain/entities/article.dart';
import 'package:headline_news_getx/domain/repositories/article_repository.dart';

class RemoveBookmarkArticle {
  final ArticleRepository repository = Get.find<ArticleRepository>();

  Future<Either<Failure, String>> execute(Article article) {
    return repository.removeBookmarkArticle(article);
  }
}
