import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tugas1_11pplg2/Controllers/else/splash_controller.dart';

class SplashscreenPages extends StatelessWidget {
  SplashscreenPages({super.key});
  final cSplash = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("ini Splash Screen")));
  }
}
