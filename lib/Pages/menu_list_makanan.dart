import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Components/custom_form.dart';
import 'package:tugas1_11pplg2/Components/custom_card.dart';
import 'package:tugas1_11pplg2/Components/custom_appbar.dart';
import 'package:tugas1_11pplg2/Components/custom_loading.dart';
import 'package:tugas1_11pplg2/Components/custom_empty_state.dart';
import 'package:tugas1_11pplg2/Components/custom_rounded_header.dart';
import 'package:tugas1_11pplg2/Components/custom_color.dart';
import 'package:tugas1_11pplg2/Controllers/menu_makanan_controller.dart';
import 'package:tugas1_11pplg2/Controllers/responsive_layout_controller.dart';

class MenuListMakanan extends StatelessWidget {
  const MenuListMakanan({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MenuMakananController>();
    final responsive = Get.find<ResponsiveController>();

    return Scaffold(
      backgroundColor: CustomColor.greyBackground,
      appBar: const CustomAppbar(title: 'Warung Bu Madu'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor.primary,
        onPressed: () {
          Get.dialog(CustomForm(), barrierDismissible: false);
        },
        child: const Icon(Icons.add, color: CustomColor.textWhite),
      ),
      body: Column(
        children: [
          const CustomRoundedHeader(color: CustomColor.primary, height: 20),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const CustomLoading(message: 'Memuat menu...');
              }
              if (controller.makananList.isEmpty) {
                return CustomEmptyState(
                  message: 'Belum ada menu',
                  subtitle: 'Tap tombol + untuk menambah menu baru',
                  icon: Icons.restaurant_menu_outlined,
                  actionLabel: 'Tambah Menu',
                  onActionPressed: () {
                    Get.dialog(CustomForm(), barrierDismissible: false);
                  },
                );
              }

              if (responsive.isLandscape.value) {
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 4 / 2,
                  ),
                  itemCount: controller.makananList.length,
                  itemBuilder: (context, index) {
                    final entry = controller.makananList[index];
                    final item = entry.value;
                    final id = entry.key;

                    return MenuCard(
                      menuTitle: item.namaMakanan,
                      description: 'Stok tersedia: ${item.stok}',
                      price: item.formattedPrice,
                      imageUrl: item.imageAddress,
                      onEditPressed: () {
                        Get.dialog(
                          CustomForm(isEdit: true, id: id, makanan: item),
                          barrierDismissible: false,
                        );
                      },
                      onDeletePressed: () {
                        controller.confirmDeleteMakanan(id, item.namaMakanan);
                      },
                    );
                  },
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                itemCount: controller.makananList.length,
                itemBuilder: (context, index) {
                  final entry = controller.makananList[index];
                  final item = entry.value;
                  final id = entry.key;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MenuCard(
                      menuTitle: item.namaMakanan,
                      description: 'Stok tersedia: ${item.stok}',
                      price: item.formattedPrice,
                      imageUrl: item.imageAddress,
                      onEditPressed: () {
                        Get.dialog(
                          CustomForm(isEdit: true, id: id, makanan: item),
                          barrierDismissible: false,
                        );
                      },
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
