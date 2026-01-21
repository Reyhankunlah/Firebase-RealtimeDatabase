import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tugas1_11pplg2/Models/tablePremiere_model.dart';

class TablepremiereController extends GetxController {
  final isLoading = false.obs;
  var tableStanding = <Table>[].obs;
  static const String baseURL =
      'https://www.thesportsdb.com/api/v1/json/3/lookuptable.php?l=4328&s=2025-2026';

  @override
  void onInit() {
    super.onInit();
    fetchAPIPremiere();
  }

  Future<void> fetchAPIPremiere() async {
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(baseURL));
      print("\x1B[31Status Code: ${response.statusCode}\x1B[0m");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // ✅ mapping JSON ke model utama
        final model = TablePremierModel.fromJson(jsonData);

        // ✅ ambil list Table dari model dan assign ke observable
        tableStanding.assignAll(model.table);
      } else {
        Get.snackbar("Error", "Server returned ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
