import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/else/footballPlayer_controller.dart';

class Footballplayerbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FootballplayerController>(
      () => FootballplayerController(),
      fenix: true,
    );
  }
}
