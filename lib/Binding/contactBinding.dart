import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/else/contact_controller.dart';

class Contactbinding extends Bindings {
  @override
  void dependencies() {
    Get.put((ContactController()));
  }
}
