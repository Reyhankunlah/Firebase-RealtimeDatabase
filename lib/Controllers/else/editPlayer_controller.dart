import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/else/footballPlayer_controller.dart';

class EditplayerController extends GetxController {
  final nameC = TextEditingController();
  final positionC = TextEditingController();
  final numberC = TextEditingController();

  late int index;
  late FootballplayerController footballCtrl;

  @override
  void onInit() {
    super.onInit();
    footballCtrl = Get.find<FootballplayerController>();

    index = Get.arguments as int;

    final p = footballCtrl.players[index];
    nameC.text = p.name;
    positionC.text = p.position;
    numberC.text = p.number.toString();
  }

  void save() {
    final name = nameC.text.trim();
    final position = positionC.text.trim();
    final numberParsed = int.tryParse(numberC.text.trim());

    if (name.isEmpty || position.isEmpty || numberParsed == null) {
      Get.snackbar(
        "Validasi",
        "Nama/Posisi/No punggung tidak valid.",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    footballCtrl.updatePlayer(
      index,
      name: name,
      position: position,
      number: numberParsed,
    );

    Get.back();
    Get.snackbar(
      "Berhasil",
      "Data pemain diperbarui.",
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  @override
  void onClose() {
    nameC.dispose();
    positionC.dispose();
    numberC.dispose();
    super.onClose();
  }
}
