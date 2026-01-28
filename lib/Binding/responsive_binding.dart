import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/responsive_layout_controller.dart';

class ResponsiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResponsiveController>(() => ResponsiveController());
  }
}
