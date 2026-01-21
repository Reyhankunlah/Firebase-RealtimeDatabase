import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:tugas1_11pplg2/Controllers/else/footballPlayer_controller.dart';
import 'package:tugas1_11pplg2/Routes/routes.dart';

class ExWidescreen extends StatelessWidget {
  ExWidescreen({super.key});

  final cntrlFootballPlayer = Get.find<FootballplayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("World Cup 2050")),
      body: Obx(() {
        return Container(
          margin: EdgeInsets.all(45),
          child: GridView.builder(
            itemCount: cntrlFootballPlayer.players.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              final p = cntrlFootballPlayer.players[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.editPlayerPage, arguments: index);
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          foregroundImage:
                              (p.photo != null && p.photo!.isNotEmpty)
                              ? AssetImage(p.photo!)
                              : null,
                          onForegroundImageError: (exception, stackTrace) {
                            debugPrint(
                              'Gagal load asset: ${p.photo} -> $exception',
                            );
                          },
                          child: Text(
                            p.number.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${p.position} • #${p.number}",
                          style: const TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
