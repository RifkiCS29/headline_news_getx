import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/presentation/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebviewPage extends StatefulWidget {
  const ArticleWebviewPage({Key? key}) : super(key: key);

  @override
  State<ArticleWebviewPage> createState() => _ArticleWebviewPageState();
}

class _ArticleWebviewPageState extends State<ArticleWebviewPage> {
  final String url = Get.arguments as String;
  final WebViewController webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    webViewController
      ..loadRequest(Uri.parse(url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
