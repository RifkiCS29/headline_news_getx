import 'package:get/get.dart';
import 'package:headline_news_getx/common/state_enum.dart';
import 'package:headline_news_getx/domain/entities/article.dart';
import 'package:headline_news_getx/domain/usecases/get_bookmark_articles.dart';

class BookmarkArticleController extends GetxController {
  final GetBookmarkArticles _getBookmarkArticles;

  BookmarkArticleController(
    this._getBookmarkArticles,
  );

  Rx<List<Article>?> dataBookmark = Rx<List<Article>?>(null);
  Rx<RequestState> bookmarkArticleState =
      Rx<RequestState>(RequestState.loading);
  Rx<String> message = Rx<String>('');

  void fetchBookmarkArticles() async {
    bookmarkArticleState.value = RequestState.loading;

    final result = await _getBookmarkArticles.execute();

    result.fold(
      (failure) {
        bookmarkArticleState.value = RequestState.error;
        message.value = failure.message;
      },
      (bookmarkData) {
        bookmarkArticleState.value = RequestState.loaded;
        dataBookmark.value = bookmarkData;
        if (bookmarkData.isEmpty) {
          bookmarkArticleState.value = RequestState.empty;
        }
      },
    );
  }
}
