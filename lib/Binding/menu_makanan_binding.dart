// Bindings/makanan_binding.dart
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/menu_makanan_controller.dart';

class MenuMakananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuMakananController>(() => MenuMakananController());
  }
}