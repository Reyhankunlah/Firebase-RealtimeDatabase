
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tugas1_11pplg2/Models/menu_makanan_model.dart';

class MenuMakananController extends GetxController {
  // CONTROLLER BUAT ULANG (MASIH DUMMY)
  var isLoading = false.obs;
  var makananList = <MapEntry<String, ItemMakanan>>[].obs;
  var errorMessage = ''.obs;

  // base url firebase
  final String baseUrl = 'https://flutterpushtest-1d5f7-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  void onInit() {
    super.onInit();
    fetchMakanan(); 
  }

  Future<void> fetchMakanan() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(
        Uri.parse('$baseUrl/.json'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final makananResponse = MakananResponse.fromJson(jsonData);
        
        makananList.value = makananResponse.toList();
        
        print('Total makanan berhasil dimuat: ${makananList.length}');
      } else {
        errorMessage.value = 'Gagal memuat data: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print('Error fetch makanan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createMakanan(String nama, int harga) async {
    try {
      isLoading.value = true;

      final newData = {
        'nama_makanan': nama,
        'harga_makanan': harga,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/makanan.json'),
        body: json.encode(newData),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil',
          'Makanan berhasil ditambahkan',
          snackPosition: SnackPosition.BOTTOM,
        );
        await fetchMakanan();
      } else {
        Get.snackbar(
          'Gagal',
          'Gagal menambahkan makanan',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error create makanan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateMakanan(String id, String nama, int harga) async {
    try {
      isLoading.value = true;

      final updateData = {
        'nama_makanan': nama,
        'harga_makanan': harga,
      };

      final response = await http.patch(
        Uri.parse('$baseUrl/makanan/$id.json'),
        body: json.encode(updateData),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil',
          'Makanan berhasil diupdate',
          snackPosition: SnackPosition.BOTTOM,
        );
        await fetchMakanan();
      } else {
        Get.snackbar(
          'Gagal',
          'Gagal mengupdate makanan',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error update makanan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteMakanan(String id) async {
    try {
      isLoading.value = true;

      final response = await http.delete(
        Uri.parse('$baseUrl/makanan/$id.json'),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil',
          'Makanan berhasil dihapus',
          snackPosition: SnackPosition.BOTTOM,
        );
        await fetchMakanan();
      } else {
        Get.snackbar(
          'Gagal',
          'Gagal menghapus makanan',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error delete makanan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshMakanan() async {
    await fetchMakanan();
  }
}