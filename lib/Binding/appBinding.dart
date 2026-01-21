import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/else/calculator_controller.dart';
import 'package:tugas1_11pplg2/Controllers/else/editPlayer_controller.dart';
import 'package:tugas1_11pplg2/Controllers/else/footballPlayer_controller.dart';
import 'package:tugas1_11pplg2/Controllers/API/loginAPI_controller.dart';
import 'package:tugas1_11pplg2/Controllers/else/login_controller.dart';
import 'package:tugas1_11pplg2/Controllers/nav/navigation_controller.dart';
import 'package:tugas1_11pplg2/Controllers/else/splash_controller.dart';

class Appbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalculatorController>(() => CalculatorController());
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<FootballplayerController>(
      () => FootballplayerController(),
      fenix: true,
    );
    Get.lazyPut<EditplayerController>(
      () => EditplayerController(),
      fenix: true,
    );
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<LoginapiController>(() => LoginapiController());
  }
}
