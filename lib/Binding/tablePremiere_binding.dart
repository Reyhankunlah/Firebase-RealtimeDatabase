import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/API/tablePremiere_controller.dart';

class TablepremiereBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TablepremiereController());
  }
}
