import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:headline_news_getx/common/theme.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 2000), () {
      Get.offNamed('main-page');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 330,
            width: 300,
            child: Lottie.asset(
              'assets/news.json',
              width: 350,
              height: 350,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
