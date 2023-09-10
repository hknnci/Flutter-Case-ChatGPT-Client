import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextStyle titleTextStyle({bool isTextWhite = true}) {
    return TextStyle(
      color: isTextWhite ? Colors.white : const Color(0xFFB6FBFF),
      fontSize: 48,
      fontWeight: FontWeight.w700,
      height: 0.98,
    );
  }
}
