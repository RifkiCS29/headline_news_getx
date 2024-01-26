import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:headline_news_getx/common/theme.dart';
import 'package:headline_news_getx/common/utils.dart';
import 'package:headline_news_getx/presentation/pages/article_category_page.dart';
import 'package:headline_news_getx/presentation/pages/article_webview_page.dart';
import 'package:headline_news_getx/presentation/pages/detail_page.dart';
import 'package:headline_news_getx/presentation/pages/splash_page.dart';
import 'package:headline_news_getx/common/http_ssl_pinning.dart';
import 'package:headline_news_getx/injection.dart' as di;
import 'package:headline_news_getx/presentation/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  di.init();
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
      navigatorObservers: [routeObserver],
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashPage(),
        ),
        GetPage(
          name: '/main-page',
          page: () => const MainPage(),
        ),
        GetPage(
          name: '/detail',
          page: () => const DetailPage(),
        ),
        GetPage(
          name: '/article-category',
          page: () => const ArticleCategoryPage(),
        ),
        GetPage(
          name: '/webview',
          page: () => const ArticleWebviewPage(),
        ),
      ],
    );
  }
}
