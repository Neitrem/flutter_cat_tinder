import 'package:cinder/ui/styles/colors.dart';
import 'package:flutter/material.dart';

TextStyle commonTextStyleLight = const TextStyle(
    color: white, fontSize: 16.0, fontWeight: FontWeight.normal);

TextStyle commonTextStyleDark = const TextStyle(
    color: darkGrey, fontSize: 16.0, fontWeight: FontWeight.normal);

TextStyle hintTextStyle = const TextStyle(
    color: lightGrey, fontSize: 16, fontWeight: FontWeight.w300);

TextStyle titleTextStyle = const TextStyle(
    color: darkGrey,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 3);

TextStyle logoTextStyle = const TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w600,
  letterSpacing: 5,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(0.0, -2.0),
      blurRadius: 0.0,
    ),
  ],
);
