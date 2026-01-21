// lib/nav/main_nav_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/nav/navigation_controller.dart';
import 'package:tugas1_11pplg2/Pages/nav/sideDrawerPage.dart';

class BtmNavigationPage extends StatelessWidget {
  BtmNavigationPage({super.key});

  final NavigationController navigationController =
      Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navigationController.selectedIndex.value,
      onTap: navigationController.changeIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calc'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_soccer),
          label: 'Squad',
        ),
      ],
    );
  }
}
