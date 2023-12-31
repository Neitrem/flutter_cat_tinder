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

const Gradient likeColorGragient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment(0.8, 1),
  colors: <Color>[
    Color(0xff4ef54b),
    Color.fromARGB(24, 75, 245, 211),
  ], // Gradient from https://learnui.design/tools/gradient-generator.html
  tileMode: TileMode.clamp,
);

const Gradient favoriteColorGragient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment(0.8, 1),
  colors: <Color>[
    Color(0xffE54BF5),
    Color(0xff61E7F7),
  ], // Gradient from https://learnui.design/tools/gradient-generator.html
  tileMode: TileMode.clamp,
);

const Gradient dislikeColorGragient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment(0.8, 1),
  colors: <Color>[
    Color.fromARGB(255, 244, 35, 35),
    Color.fromARGB(16, 224, 114, 114),
  ], // Gradient from https://learnui.design/tools/gradient-generator.html
  tileMode: TileMode.clamp,
);

const Color secondaryColor = Color(0xff232936);

const Color darkGrey = Color(0xff4C566C);

const Color lightGrey = Color.fromARGB(255, 111, 109, 109);

const Color white = Color(0xffffffff);