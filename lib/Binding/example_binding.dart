import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/ex/example_controller.dart';

class ExampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExampleController>(() => ExampleController());
  }
}
