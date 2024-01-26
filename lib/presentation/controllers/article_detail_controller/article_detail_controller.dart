import 'package:get/get.dart';
import 'package:headline_news_getx/domain/entities/article.dart';
import 'package:headline_news_getx/domain/usecases/get_bookmark_status.dart';
import 'package:headline_news_getx/domain/usecases/remove_bookmark_article.dart';
import 'package:headline_news_getx/domain/usecases/save_bookmark_article.dart';

class ArticleDetailController extends GetxController {
  final GetBookmarkStatus getBookmarkStatus = Get.find<GetBookmarkStatus>();
  final SaveBookmarkArticle saveBookmarkArticle =
      Get.find<SaveBookmarkArticle>();
  final RemoveBookmarkArticle removeBookmarkArticle =
      Get.find<RemoveBookmarkArticle>();

  RxString bookmarkMessage = ''.obs;
  RxBool isAddedToBookmark = false.obs;

  Future<void> addToBookmark(Article article) async {
    final result = await saveBookmarkArticle.execute(article);

    result.fold(
      (failure) => bookmarkMessage.value = failure.message,
      (successMessage) {
        bookmarkMessage.value = successMessage;
        // Show snackbar only when the action is successful
        Get.snackbar('Bookmark', successMessage);
      },
    );

    loadBookmarkStatus(article.url ?? '');
  }

  Future<void> removeFromBookmark(Article article) async {
    final result = await removeBookmarkArticle.execute(article);

    result.fold(
      (failure) => bookmarkMessage.value = failure.message,
      (successMessage) {
        bookmarkMessage.value = successMessage;
        // Show snackbar only when the action is successful
        Get.snackbar('Bookmark', successMessage);
      },
    );

    loadBookmarkStatus(article.url ?? '');
  }

  Future<void> loadBookmarkStatus(String url) async {
    final result = await getBookmarkStatus.execute(url);
    isAddedToBookmark.value = result;
  }
}
