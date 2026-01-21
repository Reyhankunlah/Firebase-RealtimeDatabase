import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas1_11pplg2/Routes/routes.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  login() async {
    if (usernameController.text.toString() == "asd" &&
        passwordController.text.toString() == "asd") {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("username", usernameController.text.toString());
      Get.offAllNamed(AppRoutes.mainNav);
    } else {
      Get.snackbar("Error", "Invalid Username / Password");
    }
  }
}
