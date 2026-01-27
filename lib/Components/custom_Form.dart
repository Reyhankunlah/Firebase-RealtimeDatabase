import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEdit ? 'Edit Menu' : 'Tambah Menu',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama Makanan'),
            ),
            TextField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga'),
            ),
            TextField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Stok'),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC04848),
                minimumSize: const Size.fromHeight(45),
              ),
              onPressed: () {
                if (isEdit) {
                  controller.updateMakanan(
                    id!,
                    namaController.text,
                    int.parse(hargaController.text),
                    int.parse(stokController.text),
                    imageController.text,
                  );
                } else {
                  controller.createMakanan(
                    namaController.text,
                    int.parse(hargaController.text),
                    int.parse(stokController.text),
                    imageController.text,
                  );
                }

                Get.back();
              },
              child: Text(
                isEdit ? 'Update Menu' : 'Simpan Menu',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
