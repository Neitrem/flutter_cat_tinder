import 'package:flutter/material.dart';

class WaveProvider extends ChangeNotifier {
  late double currentWaveHeight = startWaveHeight;

  final double startWaveHeight;
  final double finalWaveHeight;

  WaveProvider({
    required this.startWaveHeight,
    required this.finalWaveHeight,
  });

  Future<void> setNewHeight() async {
    try {
      await Future.delayed(const Duration(seconds: 1), () {});
      currentWaveHeight = finalWaveHeight;
      notifyListeners();
    } catch (e) {}
  }
}
