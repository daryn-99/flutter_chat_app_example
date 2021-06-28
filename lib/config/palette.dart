import 'package:flutter/material.dart';

class Palette {
  static const Color scaffold = Color(0xFFFF8200);

  static const Color colorBlue = Color(0xFF0046BB);

  static const Color colorYellow = Color(0xFFFFF100);

  static const LinearGradient createRoomGradient = LinearGradient(
    colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  );

  static const Color online = Color(0xFF4BCB1F);

  static const LinearGradient storyGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, Colors.black26]);
}
