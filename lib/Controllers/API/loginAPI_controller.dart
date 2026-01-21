import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas1_11pplg2/Models/loginAPI_model.dart';
import 'package:tugas1_11pplg2/Routes/routes.dart';

class LoginapiController extends GetxController {
  final inpUsername = TextEditingController();
  final inpPassword = TextEditingController();

  final isLoading = false.obs;
  static const String baseURL = 'mediadwi.com';

  // Menyimpan token (dari SharedPreferences)
  RxString token = ''.obs;

  Future<void> loginLogic() async {
    final user = inpUsername.text.trim();
    final pass = inpPassword.text.trim();

    if (user.isEmpty || pass.isEmpty) {
      Get.snackbar('Error', 'Username dan password tidak boleh kosong');
      return;
    }

    isLoading.value = true;

    final url = Uri.https(baseURL, '/api/latihan/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'username': user, 'password': pass},
    );

    try {
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final loginData = LoginModel.fromJson(jsonData);

        Get.snackbar('LOGIN STATUS', loginData.message);

        if (loginData.status) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', loginData.token ?? '');

          token.value = loginData.token ?? '';

          Get.offAllNamed(AppRoutes.mainNav);
        }
      } else {
        Get.snackbar('Error', 'Gagal login: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token');

    if (savedToken != null && savedToken.isNotEmpty) {
      token.value = savedToken;
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    token.value = '';
    Get.offAllNamed(AppRoutes.LoginPage);
    Get.snackbar('Logout', 'Berhasil keluar dari akun');
  }
}
