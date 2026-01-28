import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class ResponsiveController extends GetxController with WidgetsBindingObserver {
  final isLandscape = false.obs;
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateOrientation();
    });
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      _updateOrientation();
    });
  }

  void _updateOrientation() {
    final context = Get.context;
    if (context == null) return;

    final size = MediaQuery.of(context).size;
    final newIsLandscape = size.width > size.height;
    
    if (isLandscape.value != newIsLandscape) {
      isLandscape.value = newIsLandscape;
    }
  }
}