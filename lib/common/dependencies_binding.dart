import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/common/http_ssl_pinning.dart';
import 'package:headline_news_getx/common/network_info.dart';
import 'package:headline_news_getx/data/datasources/article_local_data_source.dart';
import 'package:headline_news_getx/data/datasources/article_remote_data_source.dart';
import 'package:headline_news_getx/data/datasources/db/database_helper.dart';
import 'package:headline_news_getx/data/repositories/article_repository_impl.dart';
import 'package:headline_news_getx/domain/repositories/article_repository.dart';
import 'package:headline_news_getx/domain/usecases/get_article_category.dart';
import 'package:headline_news_getx/domain/usecases/get_bookmark_articles.dart';
import 'package:headline_news_getx/domain/usecases/get_bookmark_status.dart';
import 'package:headline_news_getx/domain/usecases/get_headline_business_articles.dart';
import 'package:headline_news_getx/domain/usecases/get_top_headline_articles.dart';
import 'package:headline_news_getx/domain/usecases/remove_bookmark_article.dart';
import 'package:headline_news_getx/domain/usecases/save_bookmark_article.dart';
import 'package:headline_news_getx/domain/usecases/search_articles.dart';

class DependenciesBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    //usecase
    Get.lazyPut(() => GetTopHeadlineArticles());
    Get.lazyPut(() => GetHeadlineBusinessArticles());
    Get.lazyPut(() => GetArticleCategory());
    Get.lazyPut(() => SearchArticles());
    Get.lazyPut(() => GetBookmarkArticles());
    Get.lazyPut(() => GetBookmarkStatus());
    Get.lazyPut(() => SaveBookmarkArticle());
    Get.lazyPut(() => RemoveBookmarkArticle());

    //repository
    Get.lazyPut<ArticleRepository>(
      () => ArticleRepositoryImpl(),
    );

    //data source
    Get.lazyPut<ArticleRemoteDataSource>(
      () => ArticleRemoteDataSourceImpl(),
    );
    Get.lazyPut<ArticleLocalDataSource>(
      () => ArticleLocalDataSourceImpl(),
    );

    // helper
    Get.lazyPut<DatabaseHelper>(() => DatabaseHelper());

    // network info
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl());

    // external
    Get.lazyPut(() => HttpSSLPinning.client);
    Get.lazyPut(() => DataConnectionChecker());
  }
}
