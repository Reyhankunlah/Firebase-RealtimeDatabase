import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Components/custom_button.dart';
import 'package:tugas1_11pplg2/Components/custom_input.dart';
import 'package:tugas1_11pplg2/Components/custom_text.dart';
import 'package:tugas1_11pplg2/Controllers/else/contact_controller.dart';

class ContactPage extends StatelessWidget {
  ContactPage({super.key});

  final contactC = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: CustomInput(
                      label: "Nama Kontak",
                      controller: contactC.nameController,
                      isNumber: false,
                    ),
                  ),
                ),
                CustomButton(
                  myText: "Save",
                  myTextColor: Colors.black,
                  onPressed: contactC.addName,
                ),
              ],
            ),

            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: contactC.names.length,
                  itemBuilder: (context, index) {
                    final contact = contactC.names[index];

                    return ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ),
                      title: CustomText(myText: contact['name']),

                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          showDialog(
                            context: context,

                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Hapus'),
                                content: const Text(
                                  'Apakah Anda yakin ingin menghapus kontak ini?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      contactC.delete(contact['id']);
                                    },
                                    child: const Text('Hapus'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      onTap: () {
                        contactC.editController.text = contact['name'];
                        contactC.selectedId.value = contact['id'];

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Update Name'),
                              content: CustomInput(
                                label: 'New Name',
                                controller: contactC.editController,
                                isNumber: false,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await contactC.updateName();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Update'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
