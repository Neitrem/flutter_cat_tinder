import 'package:flutter/material.dart';

const Color primaryColor = Color(0xfff54b64);

const Gradient primaryColorGragient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment(0.8, 1),
  colors: <Color>[
    Color(0xfff54b64),
    Color(0xfff78361),
  ], // Gradient from https://learnui.design/tools/gradient-generator.html
  tileMode: TileMode.clamp,
);

const Color secondaryColor = Color(0xff232936);

const Color darkGrey = Color(0xff4C566C);

const Color lightGrey = Color.fromARGB(255, 111, 109, 109);

const Color white = Color(0xffffffff);

const TextStyle commonTextStyleLight = TextStyle(
  color: white,
  fontSize: 16.0,
  fontWeight: FontWeight.normal
);

const TextStyle commonTextStyleDark = TextStyle(
  color: darkGrey,
  fontSize: 16.0,
  fontWeight: FontWeight.normal
);

const TextStyle hintTextStyle = TextStyle(
  color: lightGrey,
  fontSize: 16,
  fontWeight: FontWeight.w300
);

const TextStyle titleTextStyle = TextStyle(
  color: darkGrey,
  fontSize: 18,
  fontWeight: FontWeight.w400,
  letterSpacing: 3
);

ButtonStyle primaryButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
  shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
  textStyle: MaterialStateProperty.all<TextStyle>(commonTextStyleLight)
);

const BorderRadius borderRadius = BorderRadius.all(Radius.circular(5.0));
