import 'package:dartz/dartz.dart';
import 'package:headline_news_getx/common/failure.dart';
import 'package:headline_news_getx/domain/entities/articles.dart';
import 'package:headline_news_getx/domain/repositories/article_repository.dart';

class SearchArticles {
  final ArticleRepository repository;

  SearchArticles(this.repository);

  Future<Either<Failure, Articles>> execute(String query, {int page = 1}) {
    return repository.searchArticles(query, page: page);
  }
}