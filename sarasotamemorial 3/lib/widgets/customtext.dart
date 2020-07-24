import 'package:flutter/material.dart';
import 'package:sarasotamemorial/theme.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color color;
  final double size;
  final TextAlign alignment;

  CustomText({this.title, this.color, this.size, this.alignment});

  @override
  Widget build(BuildContext context) {
    double textSize = size;
    if (textSize == 0) textSize = MyTheme.normalTextSize();
    return Text(
      title,
      textAlign: alignment,
      style: TextStyle(fontSize: textSize, fontFamily: 'Lexend', color: color),
    );
  }
}
