import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tugas1_11pplg2/Components/custom_button.dart';
import 'package:tugas1_11pplg2/Components/custom_input.dart';
import 'package:tugas1_11pplg2/Components/custom_text.dart';
import 'package:tugas1_11pplg2/Controllers/API/loginAPI_controller.dart';
import 'package:tugas1_11pplg2/Controllers/else/notification_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final cLogPage = Get.find<LoginapiController>();
  final NotificationController c = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(12),
          child: Column(
            children: [
              CustomInput(
                label: "Username",
                controller: cLogPage.inpUsername,
                isNumber: false,
              ),
              CustomInput(
                label: "Password",
                controller: cLogPage.inpPassword,
                isNumber: false,
              ),
              CustomText(myText: c.token.value),
              Obx(() {
                if (cLogPage.isLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return CustomButton(
                    onPressed: cLogPage.loginLogic,
                    myText: 'LOGIN',
                    myTextColor: Colors.black,
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
