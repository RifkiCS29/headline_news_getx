// import 'package:data_connection_checker/data_connection_checker.dart';
// import 'package:get_it/get_it.dart';
// import 'package:headline_news_getx/data/datasources/article_remote_data_source.dart';
// import 'package:headline_news_getx/data/repositories/article_repository_impl.dart';
// import 'package:headline_news_getx/domain/repositories/article_repository.dart';
// import 'package:headline_news_getx/domain/usecases/get_article_category.dart';
// import 'package:headline_news_getx/domain/usecases/get_bookmark_articles.dart';
// import 'package:headline_news_getx/domain/usecases/get_bookmark_status.dart';
// import 'package:headline_news_getx/domain/usecases/get_headline_business_articles.dart';
// import 'package:headline_news_getx/domain/usecases/get_top_headline_articles.dart';
// import 'package:headline_news_getx/domain/usecases/remove_bookmark_article.dart';
// import 'package:headline_news_getx/domain/usecases/save_bookmark_article.dart';
// import 'package:headline_news_getx/common/http_ssl_pinning.dart';
// import 'package:headline_news_getx/common/network_info.dart';
// import 'package:headline_news_getx/data/datasources/article_local_data_source.dart';
// import 'package:headline_news_getx/data/datasources/db/database_helper.dart';
// import 'package:headline_news_getx/domain/usecases/search_articles.dart';
// import 'package:headline_news_getx/presentation/controllers/article_list_controller/article_list_controller.dart';

// final locator = GetIt.instance;

// void init() {
//   //controller
//   // locator.registerFactory(
//   //   () => ArticleListController(
//   //     locator(),
//   //     locator(),
//   //   ),
//   // );

//   //usecase
//   // locator.registerLazySingleton(() => GetTopHeadlineArticles(locator()));
//   // locator.registerLazySingleton(() => GetHeadlineBusinessArticles(locator()));
//   // locator.registerLazySingleton(() => GetArticleCategory(locator()));
//   // locator.registerLazySingleton(() => SearchArticles(locator()));
//   // locator.registerLazySingleton(() => GetBookmarkArticles(locator()));
//   // locator.registerLazySingleton(() => GetBookmarkStatus(locator()));
//   // locator.registerLazySingleton(() => SaveBookmarkArticle(locator()));
//   // locator.registerLazySingleton(() => RemoveBookmarkArticle(locator()));

//   //repository
//   // locator.registerLazySingleton<ArticleRepository>(
//   //   () => ArticleRepositoryImpl(
//   //     remoteDataSource: locator(),
//   //     localDataSource: locator(),
//   //     networkInfo: locator(),
//   //   ),
//   // );

//   //data source
//   // locator.registerLazySingleton<ArticleRemoteDataSource>(
//   //   () => ArticleRemoteDataSourceImpl(client: locator()),
//   // );
//   // locator.registerLazySingleton<ArticleLocalDataSource>(
//   //   () => ArticleLocalDataSourceImpl(databaseHelper: locator()),
//   // );

//   // helper
//   locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

//   // network info
//   // locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

//   // external
//   locator.registerLazySingleton(() => HttpSSLPinning.client);
//   locator.registerLazySingleton(() => DataConnectionChecker());
// }
