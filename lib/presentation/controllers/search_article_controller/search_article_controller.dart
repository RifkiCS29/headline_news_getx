import 'package:get/get.dart';
import 'package:headline_news_getx/common/state_enum.dart';
import 'package:headline_news_getx/domain/entities/article.dart';
import 'package:headline_news_getx/domain/usecases/search_articles.dart';

class SearchArticleController extends GetxController {
  final SearchArticles _searchArticles;

  RxList<Article> articles = <Article>[].obs;
  Rx<RequestState> state = Rx<RequestState>(RequestState.initial);
  Rx<int> totalResult = 0.obs;
  Rx<int> currentPage = 1.obs;
  Rx<String> message = ''.obs;

  SearchArticleController(this._searchArticles);

  void onQueryChanged(String query) async {
    if (query.isEmpty) {
      _updateState(RequestState.initial);
    } else {
      _updateState(RequestState.loading);
      final result = await _searchArticles.execute(query);
      result.fold(
        (failure) => _updateState(RequestState.error, message: failure.message),
        (articlesData) {
          articles.assignAll(articlesData.articles ?? []);
          _updateState(
            RequestState.loaded,
            totalResults: articlesData.totalResults ?? 0,
          );
          currentPage.value = 1;

          if (articlesData.articles?.isEmpty == true) {
            _updateState(RequestState.empty, message: 'No Result Found');
          }
        },
      );
    }
  }

  void onNextPage(String query, int page) async {
    if (query.isEmpty) {
      _updateState(RequestState.initial);
    } else {
      final result = await _searchArticles.execute(query, page: page);
      result.fold(
        (failure) => _updateState(RequestState.error, message: failure.message),
        (articleData) {
          articles.addAll(articleData.articles ?? []);
          _updateState(
            RequestState.loaded,
            totalResults: articleData.totalResults ?? 0,
          );
          currentPage.value = page + 1;

          if (articleData.articles?.isEmpty == true) {
            _updateState(RequestState.empty, message: 'No Result Found');
          }
        },
      );
    }
  }

  void _updateState(
    RequestState newState, {
    int totalResults = 0,
    String message = '',
  }) {
    state.value = newState;
    totalResult.value = totalResults;
    this.message.value = message;
  }
}
