import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:tugas1_11pplg2/Models/menu_makanan_model.dart';

class MenuMakananController extends GetxController {
  var isLoading = false.obs;
  var makananList = <MapEntry<String, ItemMakanan>>[].obs;
  var errorMessage = ''.obs;

  final String baseUrl =
      'https://flutterpushtest-1d5f7-default-rtdb.asia-southeast1.firebasedatabase.app';

  // ================= TEXT CONTROLLERS =================
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();
  final imageController = TextEditingController();

  // ================= LIFECYCLE =================
  @override
  void onInit() {
    super.onInit();
    fetchMakanan();
  }

  @override
  void onClose() {
    namaController.dispose();
    hargaController.dispose();
    stokController.dispose();
    imageController.dispose();
    super.onClose();
  }

  // ================= FORM =================
  void fillForm(ItemMakanan makanan) {
    namaController.text = makanan.namaMakanan;
    hargaController.text = makanan.hargaMakanan.toString();
    stokController.text = makanan.stok.toString();
    imageController.text = makanan.imageAddress;
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
                  await deleteDatabase(id);
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

  void clearForm() {
    namaController.clear();
    hargaController.clear();
    stokController.clear();
    imageController.clear();
  }

  void handleSubmitForm({required bool isEdit, String? id}) {
    final nama = namaController.text.trim();
    final hargaText = hargaController.text.trim();
    final stokText = stokController.text.trim();
    final imageUrl = imageController.text.trim();

    if (nama.isEmpty) return _showError('Nama makanan harus diisi!');
    if (hargaText.isEmpty) return _showError('Harga harus diisi!');
    if (stokText.isEmpty) return _showError('Stok harus diisi!');
    if (imageUrl.isEmpty) return _showError('URL gambar harus diisi!');

    final harga = int.tryParse(hargaText);
    final stok = int.tryParse(stokText);

    if (harga == null || harga <= 0) {
      return _showError('Harga harus angka positif!');
    }
    if (stok == null || stok < 0) {
      return _showError('Stok harus ≥ 0!');
    }
    if (!imageUrl.startsWith('http')) {
      return _showError('URL harus diawali http/https');
    }

    if (isEdit) {
      updateMakanan(id!, nama, harga, stok, imageUrl);
    } else {
      createMakanan(nama, harga, stok, imageUrl);
    }

    clearForm();
    Get.back();
  }

  // ================= API =================
  Future<void> fetchMakanan() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('$baseUrl/.json'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        makananList.value = MakananResponse.fromJson(jsonData).toList();
      }
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
    final newId = 'm${makananList.length + 1}';
    await http.put(
      Uri.parse('$baseUrl/makanan/$newId.json'),
      body: json.encode({
        'nama_makanan': nama,
        'harga_makanan': harga,
        'stock_makanan': stok,
        'image_address': imageUrl,
      }),
    );
    fetchMakanan();
  }

  Future<void> updateMakanan(
    String id,
    String nama,
    int harga,
    int stok,
    String imageUrl,
  ) async {
    await http.patch(
      Uri.parse('$baseUrl/makanan/$id.json'),
      body: json.encode({
        'nama_makanan': nama,
        'harga_makanan': harga,
        'stock_makanan': stok,
        'image_address': imageUrl,
      }),
    );
    fetchMakanan();
  }

  // ================= UI =================
  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
