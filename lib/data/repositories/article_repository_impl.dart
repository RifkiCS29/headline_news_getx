import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/common/network_info.dart';
import 'package:headline_news_getx/data/datasources/article_local_data_source.dart';
import 'package:headline_news_getx/data/datasources/article_remote_data_source.dart';
import 'package:headline_news_getx/data/models/article_table.dart';
import 'package:headline_news_getx/domain/entities/article.dart';
import 'package:headline_news_getx/domain/entities/articles.dart';
import 'package:headline_news_getx/domain/repositories/article_repository.dart';
import 'package:headline_news_getx/common/exception.dart';
import 'package:headline_news_getx/common/failure.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource =
      Get.find<ArticleRemoteDataSource>();
  final ArticleLocalDataSource localDataSource =
      Get.find<ArticleLocalDataSource>();
  final NetworkInfo networkInfo = Get.find<NetworkInfo>();

  @override
  Future<Either<Failure, List<Article>>> getTopHeadlineArticles() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopHeadlineArticles();
        localDataSource.cacheTopHeadlineArticles(
          result.articles
                  ?.map((article) => ArticleTable.fromDTO(article))
                  .toList() ??
              [],
        );
        return Right(
          result.articles?.map((model) => model.toEntity()).toList() ?? [],
        );
      } on ServerException {
        return const Left(ServerFailure(''));
      } on TlsException catch (e) {
        return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedTopHeadlineArticles();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getHeadlineBusinessArticles() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getHeadlineBusinessArticles();
        localDataSource.cacheHeadlineBusinessArticles(
          result.articles
                  ?.map((article) => ArticleTable.fromDTO(article))
                  .toList() ??
              [],
        );
        return Right(
          result.articles?.map((model) => model.toEntity()).toList() ?? [],
        );
      } on ServerException {
        return const Left(ServerFailure(''));
      } on TlsException catch (e) {
        return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
      }
    } else {
      try {
        final result =
            await localDataSource.getCachedHeadlineBusinessArticles();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getArticleCategory(
    String category,
  ) async {
    try {
      final result = await remoteDataSource.getArticleCategory(category);
      return Right(
        result.articles?.map((model) => model.toEntity()).toList() ?? [],
      );
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, Articles>> searchArticles(
    String query, {
    int page = 1,
  }) async {
    try {
      final result = await remoteDataSource.searchArticles(query, page);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, String>> saveBookmarkArticle(Article article) async {
    try {
      final result = await localDataSource
          .insertBookmarkArticle(ArticleTable.fromEntity(article));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeBookmarkArticle(Article article) async {
    try {
      final result = await localDataSource
          .removeBookmarkArticle(ArticleTable.fromEntity(article));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToBookmarkArticle(String url) async {
    final result = await localDataSource.getArticleByUrl(url);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Article>>> getBookmarkArticles() async {
    final result = await localDataSource.getBookmarkArticles();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
