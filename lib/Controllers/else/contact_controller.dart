import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Database/db_helper.dart';

class ContactController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController editController = TextEditingController();
  final names = <Map<String, dynamic>>[].obs;
  final _dbHelper = DBHelper();

  final selectedId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNames();
  }

  Future<void> fetchNames() async {
    final data = await _dbHelper.getNames();
    names.value = data;
  }

  Future<void> addName() async {
    final text = nameController.text.trim();
    if (text.isEmpty) return;
    await _dbHelper.insertName(text);
    nameController.clear();
    fetchNames();
  }

  Future<void> delete(int id) async {
    await _dbHelper.delete(id);
    fetchNames();
  }

  Future<void> updateName() async {
    final text = editController.text.trim();
    if (text.isEmpty || selectedId.value == 0) return;

    await _dbHelper.update(selectedId.value, text);
    editController.clear();
    selectedId.value = 0;
    fetchNames();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
