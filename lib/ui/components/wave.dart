import 'dart:math';

import 'package:cinder/ui/provider/wave_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaveContainer extends StatefulWidget {
  final Duration duration;
  final double width;
  final Color waveColor;

  const WaveContainer({super.key, 
    required this.duration,
    required this.width,
    required this.waveColor,
  });

  
  @override
  State<WaveContainer> createState() => _WaveContainerState();
}

class _WaveContainerState extends State<WaveContainer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Duration _duration;
  late Color _waveColor;


  @override
  void initState() {
    super.initState();

    _duration = widget.duration;
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _waveColor = widget.waveColor;

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 8),
      width: widget.width,
      height: Provider.of<WaveProvider>(context).currentWaveHeight,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return CustomPaint(
            painter: WavePainter(
                waveAnimation: _animationController, waveColor: _waveColor),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.stop();
    _animationController?.dispose();
    super.dispose();
  }
}

class WavePainter extends CustomPainter {
  Animation<double> waveAnimation;
  Color waveColor;

  WavePainter({required this.waveAnimation, required this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    for (double i = 0.0; i < size.width; i++) {
      path.lineTo(i,
          sin((i / size.width * 1 * pi) + (waveAnimation.value * 2 * pi)) * 20);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    Paint wavePaint = Paint()..color = waveColor;
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
