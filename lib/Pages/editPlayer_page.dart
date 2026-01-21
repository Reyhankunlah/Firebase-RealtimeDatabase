import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tugas1_11pplg2/Components/custom_button.dart';
import 'package:tugas1_11pplg2/Components/custom_input.dart';
import 'package:tugas1_11pplg2/Controllers/else/editPlayer_controller.dart';

class EditplayerPage extends StatelessWidget {
  EditplayerPage({super.key});

  final edtPlayerController = Get.put(EditplayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Player")),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            CustomInput(
              label: "Nama",
              controller: edtPlayerController.nameC,
              isPassword: false,
              inputType: TextInputType.text,
              isNumber: false,
            ),
            CustomInput(
              label: "Posisi",
              controller: edtPlayerController.positionC,
              isPassword: false,
              inputType: TextInputType.text,
              isNumber: false,
            ),
            CustomInput(
              label: "Nomor Punggung",
              controller: edtPlayerController.numberC,
              isPassword: false,
              inputType: TextInputType.text,
              isNumber: true,
            ),

            CustomButton(
              myText: "Save",
              myTextColor: Colors.green,
              onPressed: edtPlayerController.save,
            ),
          ],
        ),
      ),
    );
  }
}
