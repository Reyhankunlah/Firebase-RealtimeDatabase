import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/else/calculator_controller.dart';

class CalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CalculatorController());
  }
}
