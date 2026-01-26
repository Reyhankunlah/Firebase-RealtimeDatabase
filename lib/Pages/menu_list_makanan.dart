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
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      /// ================= FLOATING ADD BUTTON =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFC04848),
        elevation: 4,
        onPressed: () {
          // TODO: arahkan ke halaman tambah menu
          // contoh:
          Get.dialog(CustomForm());
          print('Add Menu Clicked');
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      /// =======================================================
      body: Column(
        children: [
          Container(
            width: double.infinity,
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
            child: Transform.translate(
              offset: const Offset(0, 10),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFC04848)),
                  );
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          controller.errorMessage.value,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: controller.fetchMakanan,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC04848),
                          ),
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.makananList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.restaurant_menu,
                          color: Colors.grey,
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada menu',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.refreshMakanan,
                  color: const Color(0xFFC04848),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
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
                          stock: item.stok,
                          imageUrl: item.imageAddress,
                          onAddPressed: () {
                            print('Add pressed for ${item.namaMakanan}');
                          },
                          onDeletePressed: () {
                            controller.confirmDeleteMakanan(
                              id,
                              item.namaMakanan,
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
