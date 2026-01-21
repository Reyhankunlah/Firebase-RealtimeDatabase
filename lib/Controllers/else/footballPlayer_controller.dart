import 'package:get/get.dart';
import 'package:tugas1_11pplg2/Models/player_model.dart';

class FootballplayerController extends GetxController {
  final players = <Player>[
    const Player(
      name: "Messi",
      position: "RW",
      number: 10,
      photo: "assets/messi.jpeg",
    ),
    const Player(
      name: "Ronaldo",
      position: "ST",
      number: 7,
      photo: "assets/ronaldo.jpeg",
    ),
    const Player(
      name: "Arhan",
      position: "LB",
      number: 12,
      photo: "assets/arhan.png",
    ),
    const Player(
      name: "Isagi",
      position: "CF",
      number: 11,
      photo: "assets/isagi.jpg",
    ),
    const Player(
      name: "Bachira",
      position: "AM",
      number: 8,
      photo: "assets/bachira.jpg",
    ),
  ].obs;

  void updatePlayer(
    int index, {
    String? name,
    String? position,
    int? number,
    String? photo,
  }) {
    final current = players[index];
    players[index] = current.copyWith(
      name: name,
      position: position,
      number: number,
      photo: photo,
    );
  }
}
