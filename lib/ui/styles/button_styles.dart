import 'package:cinder/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

ButtonStyle primaryButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
  shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
  textStyle: MaterialStateProperty.all<TextStyle>(commonTextStyleLight),
);
