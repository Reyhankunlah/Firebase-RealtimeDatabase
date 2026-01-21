import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/nav/navigation_controller.dart';

class Navigationbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
  }
}
