import 'package:flutter/material.dart';
import 'package:sarasotamemorial/theme.dart';

class EditTextBox extends StatelessWidget {
  final String hint;
  final double size;
  final TextAlign alignment;
  final TextEditingController textEditingController;

  EditTextBox(
      {this.hint,
      this.textEditingController,
      this.size,
      @required this.alignment});

  @override
  Widget build(BuildContext context) {
    double textSize = size;
    if (textSize == 0) textSize = MyTheme.normalTextSize();

    return TextField(
      textAlign: alignment,
      obscureText: false,
      controller: textEditingController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: textSize,
            fontFamily: 'Lexend'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
