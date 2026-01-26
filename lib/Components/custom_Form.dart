import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Components/custom_input.dart';

class CustomForm extends StatelessWidget {
  CustomForm({super.key});

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                /// ===== TITLE =====
                const Center(
                  child: Text(
                    'Tambah Menu',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),

                /// ===== INPUT NAMA =====
                CustomInput(
                  label: 'Nama Makanan',
                  controller: namaController,
                  isNumber: false,
                  inputType: TextInputType.text,
                ),
                const SizedBox(height: 12),

                /// ===== INPUT HARGA =====
                CustomInput(
                  label: 'Harga',
                  controller: hargaController,
                  inputType: TextInputType.number,
                  isNumber: true,
                ),
                const SizedBox(height: 12),

                /// ===== INPUT STOK =====
                CustomInput(
                  label: 'Stok',
                  controller: stokController,
                  inputType: TextInputType.number,
                  isNumber: true,
                ),
                const SizedBox(height: 12),

                /// ===== INPUT IMAGE URL =====
                CustomInput(
                  label: 'Image Address (URL)',
                  controller: imageController,
                  isNumber: false,
                  inputType: TextInputType.url,
                ),

                const SizedBox(height: 24),

                /// ===== SAVE BUTTON (EXPANDED + OUTLINE) =====
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('Nama  : ${namaController.text}');
                          print('Harga : ${hargaController.text}');
                          print('Stok  : ${stokController.text}');
                          print('Image : ${imageController.text}');
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC04848), // FILL
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Color(0xFFC04848), // OUTLINE
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Simpan Menu',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// ===== CLOSE (X) BUTTON =====
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close),
              color: Colors.grey,
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}
