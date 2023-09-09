import 'package:chatgpt_flutter_case/controller/home_controller.dart';
import 'package:chatgpt_flutter_case/controller/splash_controller.dart';
import 'package:chatgpt_flutter_case/utils/constants.dart';
import 'package:chatgpt_flutter_case/widgets/screens/home_screen.dart';
import 'package:chatgpt_flutter_case/widgets/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(HomeController());
  Get.put(SplashController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
        fontFamily: Constants.sfProFont,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Constants.initialRoute,
      getPages: [
        GetPage(name: Constants.initialRoute, page: () => const SplashScreen()),
        GetPage(name: Constants.homeRoute, page: () => const HomeScreen()),
      ],
    );
  }
}
