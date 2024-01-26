import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:headline_news_getx/common/dependencies_binding.dart';
import 'package:headline_news_getx/common/theme.dart';
import 'package:headline_news_getx/common/utils.dart';
import 'package:headline_news_getx/presentation/bindings/article_category_binding/article_category_binding.dart';
import 'package:headline_news_getx/presentation/bindings/article_detail_binding/article_detail_binding.dart';
import 'package:headline_news_getx/presentation/bindings/article_list_binding/article_list_binding.dart';
import 'package:headline_news_getx/presentation/bindings/bookmark_article_binding/bookmark_article_binding.dart';
import 'package:headline_news_getx/presentation/bindings/search_article_binding/search_article_binding.dart';
import 'package:headline_news_getx/presentation/pages/article_category_page.dart';
import 'package:headline_news_getx/presentation/pages/article_webview_page.dart';
import 'package:headline_news_getx/presentation/pages/detail_page.dart';
import 'package:headline_news_getx/presentation/pages/splash_page.dart';
import 'package:headline_news_getx/common/http_ssl_pinning.dart';
import 'package:headline_news_getx/presentation/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await DependenciesBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Headline News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: kWhiteColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: kColorScheme.copyWith(secondary: kPrimaryColor),
        bottomNavigationBarTheme: bottomNavigationBarTheme,
      ),
      home: const SplashPage(),
      initialBinding: DependenciesBinding(),
      navigatorObservers: [routeObserver],
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashPage(),
        ),
        GetPage(
          name: '/main-page',
          page: () => const MainPage(),
          bindings: [
            ArticleListBinding(),
            SearchArticleBinding(),
            BookmarkArticleBinding(),
          ],
        ),
        GetPage(
          name: '/detail',
          page: () => DetailPage(),
          binding: ArticleDetailBinding(),
        ),
        GetPage(
          name: '/article-category',
          page: () => ArticleCategoryPage(),
          binding: ArticleCategoryBinding(),
        ),
        GetPage(
          name: '/webview',
          page: () => const ArticleWebviewPage(),
        ),
      ],
    );
  }
}
