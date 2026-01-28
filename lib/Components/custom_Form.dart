import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Components/custom_button.dart';
import 'package:tugas1_11pplg2/Components/custom_color.dart';
import 'package:tugas1_11pplg2/Components/custom_input.dart';
import 'package:tugas1_11pplg2/Controllers/menu_makanan_controller.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MenuMakananController>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.isEdit.value ? 'Edit Menu' : 'Tambah Menu',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),

                CustomInput(
                  label: 'Nama Makanan',
                  controller: controller.namaController,
                  prefixIcon: Icons.restaurant,
                ),

                CustomInput(
                  label: 'Harga',
                  controller: controller.hargaController,
                  isNumber: true,
                  prefixIcon: Icons.attach_money,
                ),

                CustomInput(
                  label: 'Stok',
                  controller: controller.stokController,
                  isNumber: true,
                  prefixIcon: Icons.inventory,
                ),

                CustomInput(
                  label: 'URL Gambar',
                  controller: controller.imageController,
                  prefixIcon: Icons.image,
                ),

                const SizedBox(height: 16),

                CustomButton(
                  myText: controller.isEdit.value
                      ? 'Update Menu'
                      : 'Simpan Menu',
                  onPressed: controller.submitForm,
                  backgroundColor: CustomColor.primary,
                  myTextColor: Colors.white,
                  width: double.infinity,
                ),

                const SizedBox(height: 10),

                CustomButton(
                  myText: 'Batal',
                  onPressed: () => Get.back(),
                  isOutlined: true,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
