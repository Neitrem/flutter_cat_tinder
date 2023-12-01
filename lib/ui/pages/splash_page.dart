import 'dart:math';

import 'package:cinder/ui/components/wave.dart';
import 'package:cinder/ui/provider/wave_provider.dart';
import 'package:cinder/ui/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatefulWidget {
  final Image logoImage = Image.asset("assets/CinderLogoVoid.png");
  SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: primaryColorGragient
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: ChangeNotifierProvider(
              create: (context) {
                return WaveProvider(
                  startWaveHeight: 540.0,
                  finalWaveHeight: 0.0,
                )..setNewHeight();
              },
              child: Transform.rotate(
                angle: pi,
                child: const WaveContainer(
                  width: double.infinity,
                  waveColor: white,
                  duration: Duration(milliseconds: 1000),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/CinderLogoVoid.png',
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
