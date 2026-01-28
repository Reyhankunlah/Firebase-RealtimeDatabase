import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Components/custom_color.dart';
import 'package:tugas1_11pplg2/Components/custom_input.dart';
import 'package:tugas1_11pplg2/Components/custom_button.dart';
import 'package:tugas1_11pplg2/Controllers/menu_makanan_controller.dart';
import 'package:tugas1_11pplg2/Models/menu_makanan_model.dart';

class CustomForm extends StatelessWidget {
  final bool isEdit;
  final String? id;
  final ItemMakanan? makanan;

  CustomForm({super.key, this.isEdit = false, this.id, this.makanan});

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();
  final imageController = TextEditingController();

  final controller = Get.find<MenuMakananController>();

  @override
  Widget build(BuildContext context) {
    /// AUTO FILL SAAT EDIT
    if (isEdit && makanan != null) {
      namaController.text = makanan!.namaMakanan;
      hargaController.text = makanan!.hargaMakanan.toString();
      stokController.text = makanan!.stok.toString();
      imageController.text = makanan!.imageAddress;
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// SPACING FOR CLOSE BUTTON
                    const SizedBox(height: 8),

                    /// TITLE
                    Text(
                      isEdit ? 'Edit Menu' : 'Tambah Menu',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// NAMA MAKANAN INPUT
                    CustomInput(
                      label: 'Nama Makanan',
                      hintText: 'Contoh: Nasi Goreng',
                      controller: namaController,
                      prefixIcon: Icons.restaurant,
                      isNumber: false,
                    ),

                    /// HARGA INPUT
                    CustomInput(
                      label: 'Harga',
                      hintText: 'Contoh: 15000',
                      controller: hargaController,
                      inputType: TextInputType.number,
                      isNumber: true,
                      prefixIcon: Icons.attach_money,
                    ),

                    /// STOK INPUT
                    CustomInput(
                      label: 'Stok',
                      hintText: 'Contoh: 20',
                      controller: stokController,
                      inputType: TextInputType.number,
                      isNumber: true,
                      prefixIcon: Icons.inventory_2,
                    ),

                    /// IMAGE URL INPUT
                    CustomInput(
                      label: 'URL Gambar',
                      hintText: 'https://example.com/image.jpg',
                      controller: imageController,
                      prefixIcon: Icons.image,
                      isNumber: false,
                    ),

                    const SizedBox(height: 8),

                    /// SUBMIT BUTTON
                    CustomButton(
                      myText: isEdit ? 'Update Menu' : 'Simpan Menu',
                      onPressed: _handleSubmit,
                      backgroundColor: CustomColor.primary,
                      myTextColor: CustomColor.textWhite,
                      width: double.infinity,
                    ),

                    const SizedBox(height: 12),

                    /// CANCEL BUTTON
                    CustomButton(
                      myText: 'Batal',
                      onPressed: () => Get.back(),
                      backgroundColor: CustomColor.grey,
                      myTextColor: CustomColor.textPrimary,
                      isOutlined: true,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),

            /// CLOSE BUTTON (TOP RIGHT)
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
                color: CustomColor.textSecondary,
                iconSize: 24,
                splashRadius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// HANDLE SUBMIT WITH VALIDATION
  void _handleSubmit() {
    // Validasi input kosong
    if (namaController.text.trim().isEmpty) {
      _showError('Nama makanan harus diisi!');
      return;
    }

    if (hargaController.text.trim().isEmpty) {
      _showError('Harga harus diisi!');
      return;
    }

    if (stokController.text.trim().isEmpty) {
      _showError('Stok harus diisi!');
      return;
    }

    if (imageController.text.trim().isEmpty) {
      _showError('URL gambar harus diisi!');
      return;
    }

    // Validasi angka
    final harga = int.tryParse(hargaController.text);
    final stok = int.tryParse(stokController.text);

    if (harga == null || harga <= 0) {
      _showError('Harga harus berupa angka positif!');
      return;
    }

    if (stok == null || stok < 0) {
      _showError('Stok harus berupa angka positif atau nol!');
      return;
    }

    // Validasi URL (simple)
    if (!imageController.text.startsWith('http')) {
      _showError('URL gambar harus diawali dengan http:// atau https://');
      return;
    }

    // Submit data
    try {
      if (isEdit) {
        controller.updateMakanan(
          id!,
          namaController.text.trim(),
          harga,
          stok,
          imageController.text.trim(),
        );
        _showSuccess('Menu berhasil diupdate!');
      } else {
        controller.createMakanan(
          namaController.text.trim(),
          harga,
          stok,
          imageController.text.trim(),
        );
        _showSuccess('Menu berhasil ditambahkan!');
      }

      Get.back();
    } catch (e) {
      _showError('Terjadi kesalahan: ${e.toString()}');
    }
  }

  /// SHOW ERROR SNACKBAR
  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: CustomColor.error,
      colorText: CustomColor.textWhite,
      icon: const Icon(Icons.error_outline, color: CustomColor.textWhite),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void _showSuccess(String message) {
    Get.snackbar(
      'Berhasil',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: CustomColor.success,
      colorText: CustomColor.textWhite,
      icon: const Icon(
        Icons.check_circle_outline,
        color: CustomColor.textWhite,
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
