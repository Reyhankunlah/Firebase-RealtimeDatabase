import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Components/custom_Form.dart';
import 'package:tugas1_11pplg2/Components/custom_card.dart';
import 'package:tugas1_11pplg2/Controllers/menu_makanan_controller.dart';

class MenuListMakanan extends StatelessWidget {
  const MenuListMakanan({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MenuMakananController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFC04848),
        title: const Text(
          'Warung Bu Madu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),

      /// FLOATING ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFC04848),
        onPressed: () {
          Get.dialog(CustomForm()); // ADD MODE
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Column(
        children: [
          Container(
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xFFC04848),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFFC04848)),
                );
              }

              if (controller.makananList.isEmpty) {
                return const Center(child: Text('Belum ada menu'));
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                itemCount: controller.makananList.length,
                itemBuilder: (context, index) {
                  final entry = controller.makananList[index];
                  final id = entry.key;
                  final item = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MenuCard(
                      menuTitle: item.namaMakanan,
                      description: 'Stok tersedia: ${item.stok}',
                      price: item.formattedPrice,
                      imageUrl: item.imageAddress,

                      /// EDIT
                      onEditPressed: () {
                        Get.dialog(
                          CustomForm(isEdit: true, id: id, makanan: item),
                        );
                      },

                      /// DELETE
                      onDeletePressed: () {
                        controller.confirmDeleteMakanan(id, item.namaMakanan);
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
