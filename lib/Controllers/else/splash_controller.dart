import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas1_11pplg2/Routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    checkLogin();
    super.onInit();
  }

  checkLogin() async {
    await Future.delayed(Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null) {
      Get.offAllNamed(AppRoutes.mainNav);
    } else {
      Get.offAllNamed(AppRoutes.LoginPage);
    }
  }
}
