import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:tugas1_11pplg2/Controllers/ex/example_controller.dart';
import 'package:tugas1_11pplg2/Pages/ex_feature/ex_mobile.dart';
import 'package:tugas1_11pplg2/Pages/ex_feature/ex_widescreen.dart';

class ExTransform extends StatelessWidget {
  ExTransform({super.key});

  final controller = Get.find<ExampleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constrains) {
          controller.updateLayout(constrains);
          return Obx(
            () => controller.isMobile.value ? ExMobile() : ExWidescreen(),
          );
        },
      ),
    );
  }
}
