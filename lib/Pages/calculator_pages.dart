import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Components/custom_button.dart';
import 'package:tugas1_11pplg2/Components/custom_input.dart';
import 'package:tugas1_11pplg2/Components/custom_text.dart';
import 'package:tugas1_11pplg2/Controllers/else/calculator_controller.dart';
import 'package:tugas1_11pplg2/Controllers/nav/navigation_controller.dart';

class CalculatorPages extends StatelessWidget {
  CalculatorPages({super.key});

  final calcController = Get.find<CalculatorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Input 1
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: CustomInput(
                  label: "Input Angka 1",
                  controller: calcController.txtAngka1,
                  isPassword: false,
                  inputType: TextInputType.number,
                  isNumber: true,
                ),
              ),

              // Input 2
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: CustomInput(
                  label: "Input Angka 2",
                  controller: calcController.txtAngka2,
                  isPassword: false,
                  inputType: TextInputType.number,
                  isNumber: true,
                ),
              ),

              // Tombol + dan -
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      myText: "+",
                      myTextColor: Colors.blueAccent,
                      onPressed: calcController.tambah,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: CustomButton(
                        myText: "-",
                        myTextColor: Colors.blueAccent,
                        onPressed: calcController.kurang,
                      ),
                    ),
                  ],
                ),
              ),

              // Tombol * dan /
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      myText: "*",
                      myTextColor: Colors.blueAccent,
                      onPressed: calcController.kali,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: CustomButton(
                        myText: "/",
                        myTextColor: Colors.blueAccent,
                        onPressed: calcController.bagi,
                      ),
                    ),
                  ],
                ),
              ),

              // Hasil
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Obx(() {
                  return CustomText(
                    myText: "Hasil: ${calcController.textHasil.value}",
                    myTextColor: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    align: TextAlign.center,
                  );
                }),
              ),

              // Tombol Clear
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: CustomButton(
                  myText: "Clear",
                  myTextColor: Colors.red,
                  onPressed: calcController.clear,
                ),
              ),

              // Tombol Football
              CustomButton(
                myText: "Football Page",
                myTextColor: Colors.red,
                onPressed: () {
                  Get.find<NavigationController>().changeIndex(2);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
