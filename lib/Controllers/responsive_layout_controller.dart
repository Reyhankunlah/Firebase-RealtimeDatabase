import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveController extends GetxController {
  bool get isTablet {
    final context = Get.context;
    if (context == null) return false;

    return MediaQuery.of(context).size.width >= 450;
  }
}
