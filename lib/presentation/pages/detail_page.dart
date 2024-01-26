import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/common/theme.dart';
import 'package:headline_news_getx/domain/entities/article.dart';
import 'package:headline_news_getx/injection.dart';
import 'package:headline_news_getx/presentation/controllers/article_detail_controller/article_detail_controller.dart';
import 'package:headline_news_getx/presentation/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Article article = Get.arguments as Article;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<ArticleDetailController>(
        init: ArticleDetailController(locator(), locator(), locator())
          ..loadBookmarkStatus(article.url ?? ''),
        builder: (articleDetailController) => Obx(
          () => Stack(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.bottom),
                        );
                      },
                      blendMode: BlendMode.darken,
                      child: CachedNetworkImage(
                        imageUrl: article.urlToImage ??
                            'https://sukaharja.godesa.id/assets/templates/default/artikel.png',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/errorimage.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.only(
                              left: 5,
                            ),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: kPrimaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => {
                                if (!articleDetailController
                                    .isAddedToBookmark.value)
                                  {
                                    articleDetailController
                                        .addToBookmark(article),
                                  }
                                else
                                  {
                                    articleDetailController
                                        .removeFromBookmark(article),
                                  },
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    articleDetailController
                                            .isAddedToBookmark.value
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: kPrimaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () => Share.share(
                                "${article.title}\nDetail: ${article.url}",
                              ),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.share,
                                    color: kPrimaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        bottom: 50,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy kk:mm').format(
                              article.publishedAt ?? DateTime.now(),
                            ),
                            style: whiteTextStyle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            article.title ?? 'No Title',
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: semiBold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            article.author ?? 'No Author',
                            style: whiteTextStyle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.48,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      20,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        article.description ?? '',
                        style: greyTextStyle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        article.content ?? '',
                        style: greyTextStyle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        key: const Key('button_read_more'),
                        title: 'Read More',
                        onPressed: () => Get.toNamed(
                          '/webview',
                          arguments: article.url,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
