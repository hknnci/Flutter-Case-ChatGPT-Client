import 'package:chatgpt_flutter_case/controller/splash_controller.dart';
import 'package:chatgpt_flutter_case/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => Get.offNamed(Constants.homeRoute),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(Constants.splashScreenLogo),
          ],
        ),
      ),
    );
  }
}
