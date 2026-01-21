import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tugas1_11pplg2/Controllers/nav/navigation_controller.dart';

class SideDrawerPage extends StatelessWidget {
  SideDrawerPage({super.key});

  final NavigationController navigationController =
      Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text("Calc"),
            onTap: () {
              navigationController.changeIndex(0);
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              navigationController.changeIndex(1);
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.sports_soccer),
            title: const Text("Football"),
            onTap: () {
              navigationController.changeIndex(2);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
