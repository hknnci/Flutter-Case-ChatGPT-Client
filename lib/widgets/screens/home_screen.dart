import 'package:chatgpt_flutter_case/controller/home_controller.dart';
import 'package:chatgpt_flutter_case/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          Constants.splashScreenLogo,
          width: 99.65,
          height: 14.34,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Constants.ai,
                          style: controller.titleTextStyle(isTextWhite: false),
                        ),
                        TextSpan(
                          text: Constants.chatBot,
                          style: controller.titleTextStyle(isTextWhite: true),
                        ),
                        TextSpan(
                          text: Constants.nCase,
                          style: controller.titleTextStyle(isTextWhite: true),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 13),
                  Text(
                    Constants.subText,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.53,
                      letterSpacing: 0.72,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
                        child: Text(
                          Constants.buttonContinue,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.60,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
