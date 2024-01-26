import 'package:get/get.dart';
import 'package:headline_news_getx/common/state_enum.dart';
import 'package:headline_news_getx/domain/entities/article.dart';
import 'package:headline_news_getx/domain/usecases/get_headline_business_articles.dart';
import 'package:headline_news_getx/domain/usecases/get_top_headline_articles.dart';

class ArticleListController extends GetxController {
  final GetTopHeadlineArticles _getTopHeadlineArticles;
  final GetHeadlineBusinessArticles _getHeadlineBusinessArticles;

  ArticleListController(
    this._getTopHeadlineArticles,
    this._getHeadlineBusinessArticles,
  );

  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlineArticles();
    fetchHeadlineBusinessArticles();
  }

  RxList<Article> dataTopHeadline = <Article>[].obs;
  Rx<RequestState> topHeadlineState = Rx<RequestState>(RequestState.loading);
  Rx<String> messageTopHeadline = Rx<String>('');

  Rx<List<Article>?> dataBusinessHeadline = Rx<List<Article>?>(null);
  Rx<RequestState> businessHeadlineState =
      Rx<RequestState>(RequestState.loading);
  Rx<String> messageBusinessHeadline = Rx<String>('');

  void fetchTopHeadlineArticles() async {
    topHeadlineState.value = RequestState.loading;

    final result = await _getTopHeadlineArticles.execute();

    result.fold(
      (failure) {
        topHeadlineState.value = RequestState.error;
        messageTopHeadline.value = failure.message;
      },
      (articleData) {
        topHeadlineState.value = RequestState.loaded;
        dataTopHeadline.value = articleData;
        if (articleData.isEmpty) {
          topHeadlineState.value = RequestState.empty;
        }
      },
    );
  }

  void fetchHeadlineBusinessArticles() async {
    businessHeadlineState.value = RequestState.loading;

    final result = await _getHeadlineBusinessArticles.execute();

    result.fold(
      (failure) {
        businessHeadlineState.value = RequestState.error;
        messageBusinessHeadline.value = failure.message;
      },
      (articleData) {
        businessHeadlineState.value = RequestState.loaded;
        dataBusinessHeadline.value = articleData;
        if (articleData.isEmpty) {
          topHeadlineState.value = RequestState.empty;
        }
      },
    );
  }
}
