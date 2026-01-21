import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/else/editPlayer_controller.dart';

class Editplayerbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditplayerController>(
      () => EditplayerController(),
      fenix: true,
    );
  }
}
