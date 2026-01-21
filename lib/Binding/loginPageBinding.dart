import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/API/loginAPI_controller.dart';

class Loginpagebinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginapiController(), permanent: true);
  }
}
