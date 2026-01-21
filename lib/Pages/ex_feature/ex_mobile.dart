import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Controllers/else/footballPlayer_controller.dart';
import 'package:tugas1_11pplg2/Routes/routes.dart';

class ExMobile extends StatelessWidget {
  ExMobile({super.key});

  final cntrlFootballPlayer = Get.find<FootballplayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("World Cup 2050"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          return ListView.builder(
            itemCount: cntrlFootballPlayer.players.length,
            itemBuilder: (context, index) {
              final p = cntrlFootballPlayer.players[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    foregroundImage: (p.photo != null && p.photo!.isNotEmpty)
                        ? AssetImage(p.photo!)
                        : null,
                    onForegroundImageError: (exception, stackTrace) {
                      debugPrint('Gagal load asset: ${p.photo} -> $exception');
                    },
                    child: Text(p.number.toString()),
                  ),

                  title: Text(p.name),
                  subtitle: Text("${p.position} • #${p.number}"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Get.toNamed(AppRoutes.editPlayerPage, arguments: index);
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
