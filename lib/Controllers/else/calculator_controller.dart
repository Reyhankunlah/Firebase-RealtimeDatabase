import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  final txtAngka1 = TextEditingController();
  final txtAngka2 = TextEditingController();
  var textHasil = "".obs;

  void tambah() {
    int angka1 = int.parse(txtAngka1.text);
    int angka2 = int.parse(txtAngka2.text);

    int hasilJumlah = angka1 + angka2;
    textHasil.value = hasilJumlah.toString();
  }

  void kurang() {
    int angka1 = int.parse(txtAngka1.text);
    int angka2 = int.parse(txtAngka2.text);

    int hasilJumlah = angka1 - angka2;
    textHasil.value = hasilJumlah.toString();
  }

  void kali() {
    int angka1 = int.parse(txtAngka1.text);
    int angka2 = int.parse(txtAngka2.text);

    int hasilJumlah = angka1 * angka2;
    textHasil.value = hasilJumlah.toString();
  }

  void bagi() {
    int angka1 = int.parse(txtAngka1.text);
    int angka2 = int.parse(txtAngka2.text);

    double hasilJumlah = (angka1 / angka2) as double;
    textHasil.value = hasilJumlah.toString();
  }

  void clear() {
    textHasil.value = "";
    txtAngka1.clear();
    txtAngka2.clear();
  }
}
