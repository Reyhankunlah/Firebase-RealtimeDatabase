import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tugas1_11pplg2/Models/menu_makanan_model.dart';

class MenuMakananController extends GetxController {
  var isLoading = false.obs;
  var makananList = <MapEntry<String, ItemMakanan>>[].obs;
  var errorMessage = ''.obs;

  final String baseUrl =
      'https://flutterpushtest-1d5f7-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  void onInit() {
    super.onInit();
    fetchMakanan();
  }

  Future<void> fetchMakanan() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(Uri.parse('$baseUrl/.json'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final makananResponse = MakananResponse.fromJson(jsonData);

        makananList.value = makananResponse.toList();

        print('Total makanan: ${makananList.length}');
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

  Future<void> createMakanan(
    String nama,
    int harga,
    int stok,
    String imageUrl,
  ) async {
    try {
      isLoading.value = true;

      int maxIndex = 0;
      for (var entry in makananList) {
        final key = entry.key;
        if (key.startsWith('m')) {
          final number = int.tryParse(key.substring(1)) ?? 0;
          if (number > maxIndex) {
            maxIndex = number;
          }
        }
      }

      final newId = 'm${maxIndex + 1}';

      final newData = {
        'nama_makanan': nama,
        'harga_makanan': harga,
        'stock_makanan': stok,
        'image_address': imageUrl,
      };

      final response = await http.put(
        Uri.parse('$baseUrl/makanan/$newId.json'),
        body: json.encode(newData),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil',
          'Makanan berhasil ditambahkan ($newId)',
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateMakanan(
    String id,
    String nama,
    int harga,
    int stok,
    String imageUrl,
  ) async {
    try {
      isLoading.value = true;

      final updateData = {
        'nama_makanan': nama,
        'harga_makanan': harga,
        'stock_makanan': stok,
        'image_address': imageUrl,
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
    } finally {
      isLoading.value = false;
    }
  }

  void confirmDeleteMakanan(String id, String namaMakanan) {
    const Color gojekGreen = Color(0xFFC04848);
    Get.defaultDialog(
      title: 'Hapus Menu',
      radius: 20,
      content: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              children: [
                const TextSpan(text: 'Yakin ingin menghapus menu '),
                TextSpan(
                  text: '"$namaMakanan"',
                  style: const TextStyle(
                    color: gojekGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: '?\nTindakan ini tidak bisa dibatalkan.'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: gojekGreen),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Batal',
                  style: TextStyle(
                    color: gojekGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              ElevatedButton(
                onPressed: () async {
                  Get.back();
                  await deleteMakanan(id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: gojekGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Hapus',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshMakanan() async {
    await fetchMakanan();
  }
}
