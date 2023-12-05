import 'package:cinder/ui/styles/styles.dart';
import 'package:flutter/material.dart';

class InputContainer extends StatefulWidget {
  final String hintText;
  final TextEditingController inputController;
  final bool isPassword;

  const InputContainer({
    super.key,
    required this.hintText,
    required this.inputController,
    this.isPassword = false
  });

  @override
  State<InputContainer> createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: borderRadius,
      child: Container(
        
        padding: const EdgeInsets.only(left: 20.0),
        decoration: const BoxDecoration(),
        width: 500,
        child: TextField(
          obscureText: widget.isPassword,
          controller: widget.inputController,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: hintTextStyle,
            enabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
