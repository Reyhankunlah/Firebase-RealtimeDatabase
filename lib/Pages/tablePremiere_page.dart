import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Components/custom_button.dart';
import 'package:tugas1_11pplg2/Controllers/API/googleSignin_controller.dart';
import 'package:tugas1_11pplg2/Controllers/API/tablePremiere_controller.dart';

class TablepremierePage extends StatelessWidget {
  const TablepremierePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cPremiere = Get.find<TablepremiereController>();
    final cGoogle = Get.put(GooglesigninController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // ==================== LIST TABLE PREMIERE ====================
              Expanded(
                child: Obx(() {
                  if (cPremiere.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      await cPremiere.fetchAPIPremiere();
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: cPremiere.tableStanding.length,
                      itemBuilder: (context, index) {
                        final team = cPremiere.tableStanding[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(team.strBadge),
                              radius: 25,
                            ),
                            title: Text(
                              team.strTeam.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              'Draw: ${team.intDraw} | Win: ${team.intWin} | Lose: ${team.intLoss}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: Text(
                              team.intPoints,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 12),

              // ==================== GOOGLE PROFILE SECTION ====================
              // ==================== GOOGLE PROFILE SECTION ====================
              Obx(() {
                if (cGoogle.isLoggedIn.value) {
                  final photoUrl = cGoogle.photoProfile.value;

                  return Column(
                    children: [
                      ClipOval(
                        child:
                            (photoUrl.isNotEmpty && photoUrl.startsWith('http'))
                            ? Image.network(
                                photoUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.account_circle,
                                size: 80,
                                color: Colors.red,
                              ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cGoogle.nameProfile.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        cGoogle.emailProfile.value,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  );
                } else {
                  return const Text(
                    "Belum login",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  );
                }
              }),

              const SizedBox(height: 12),

              // ==================== SIGN IN BUTTON ====================
              CustomButton(
                myText: "Sign in with Google",
                myTextColor: Colors.black,
                onPressed: () async {
                  await cGoogle.signInWithGoogle();
                },
              ),

              // ==================== LOGOUT BUTTON ====================
              CustomButton(
                myText: "Logout Google",
                myTextColor: Colors.red,
                onPressed: () async {
                  await cGoogle.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
