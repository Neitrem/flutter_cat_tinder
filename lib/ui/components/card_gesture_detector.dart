import 'dart:math';

import 'package:cinder/ui/provider/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardGestureDetector extends StatelessWidget {
  final Widget child;
  final Function(BuildContext context) onTap;
  const CardGestureDetector({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(context);
      },
      onPanStart: (details) {
        final provider = Provider.of<CardProvider>(context, listen: false);

        provider.startPosition(details);
      },
      onPanUpdate: (details) {
        final provider = Provider.of<CardProvider>(context, listen: false);

        provider.updatePosition(details);
      },
      onPanEnd: (details) {
        final provider = Provider.of<CardProvider>(context, listen: false);

        provider.endPosition();
      },
      child: LayoutBuilder(
        builder: (context, constraint) {
          final provider = Provider.of<CardProvider>(context);
          final position = provider.position;
          int milliseconds = provider.isDragging ? 0 : 600;

          final center = constraint.smallest.center(Offset.zero);
          final angle = provider.angle * pi / 180;
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);

          return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: milliseconds),
            transform: rotatedMatrix..translate(position.dx, position.dy),
            child: child,
          );
        },
      ),
    );
  }
}
