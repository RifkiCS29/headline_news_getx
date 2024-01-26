import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/common/failure.dart';
import 'package:headline_news_getx/domain/entities/article.dart';
import 'package:headline_news_getx/domain/repositories/article_repository.dart';

class GetArticleCategory {
  final ArticleRepository repository = Get.find<ArticleRepository>();

  Future<Either<Failure, List<Article>>> execute(String category) {
    return repository.getArticleCategory(category);
  }
}
