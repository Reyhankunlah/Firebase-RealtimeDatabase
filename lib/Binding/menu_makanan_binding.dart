// Bindings/makanan_binding.dart
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/menu_makanan_controller.dart';
import 'package:tugas1_11pplg2/Controllers/responsive_layout_controller.dart';

class MenuMakananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuMakananController>(() => MenuMakananController());
    Get.lazyPut<ResponsiveController>(() => ResponsiveController());
  }
}