import 'dart:convert';

import 'package:get/get.dart';
import 'package:headline_news_getx/common/config.dart';
import 'package:headline_news_getx/data/models/article_response.dart';
import 'package:headline_news_getx/common/exception.dart';
import 'package:http/http.dart' as http;

abstract class ArticleRemoteDataSource {
  Future<ArticleResponse> getTopHeadlineArticles();
  Future<ArticleResponse> getHeadlineBusinessArticles();
  Future<ArticleResponse> getArticleCategory(String category);
  Future<ArticleResponse> searchArticles(String query, int page);
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final http.Client client = Get.find();

  @override
  Future<ArticleResponse> getTopHeadlineArticles() async {
    final response = await client.get(
      Uri.parse(
        '${baseUrl}top-headlines?country=$country&apiKey=$apiKey&pageSize=10',
      ),
    );

    if (response.statusCode == 200) {
      return ArticleResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ArticleResponse> getHeadlineBusinessArticles() async {
    final response = await client.get(
      Uri.parse(
        '${baseUrl}top-headlines?country=$country&category=business&apiKey=$apiKey&pageSize=20',
      ),
    );

    if (response.statusCode == 200) {
      return ArticleResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ArticleResponse> getArticleCategory(String category) async {
    final response = await client.get(
      Uri.parse(
        '${baseUrl}top-headlines?country=$country&category=$category&apiKey=$apiKey&pageSize=30',
      ),
    );

    if (response.statusCode == 200) {
      return ArticleResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ArticleResponse> searchArticles(String query, int page) async {
    final response = await client.get(
      Uri.parse(
        '${baseUrl}everything?q=$query&apiKey=$apiKey&pageSize=$pageSize&page=$page',
      ),
    );

    if (response.statusCode == 200) {
      return ArticleResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
