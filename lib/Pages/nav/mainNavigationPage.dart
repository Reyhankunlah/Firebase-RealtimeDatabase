import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:tugas1_11pplg2/Controllers/nav/navigation_controller.dart';
import 'package:tugas1_11pplg2/Pages/nav/btmNavigationPage.dart';
import 'package:tugas1_11pplg2/Pages/nav/sideDrawerPage.dart';

class MainNavigationPage extends StatelessWidget {
  MainNavigationPage({super.key});

  final NavigationController navigationController =
      Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(),
        body: IndexedStack(
          index: navigationController.selectedIndex.value,
          children: navigationController.pages,
        ),
        bottomNavigationBar: BtmNavigationPage(),
        drawer: SideDrawerPage(),
      ),
    );
  }
}
