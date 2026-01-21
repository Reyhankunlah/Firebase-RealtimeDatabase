import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/else/splash_controller.dart';

class Splashscreenbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
