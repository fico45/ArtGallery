import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorNotifier extends StateNotifier<Color> {
  ColorNotifier() : super(Colors.red);

  void setColor(Color newColor) {
    state = newColor;
  }

  void getColor(Function(Color newColor) callback) {
    callback(state);
  }
}

final colorProvider = StateNotifierProvider<ColorNotifier, Color>((ref) {
  return ColorNotifier();
});
