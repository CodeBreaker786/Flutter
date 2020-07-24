 
import 'package:flutter/material.dart';

import '../uatheme.dart';

class UALabel extends StatelessWidget {
  final String text;
  final bool bold;
  final Color color;
  final double size;
  final TextAlign alignment;
  final double paddingTop, paddingLeft, paddingRight, paddingBottom;
  final bool shadow;

  UALabel({
    this.text,
    this.bold,
    this.color,
    this.size,
    this.alignment,
    this.paddingLeft,
    this.paddingRight,
    this.paddingBottom,
    this.paddingTop,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    double textSize = size;
    bool isBold = bold;
    bool isShadow = shadow;
    TextAlign align = alignment;
    double top = paddingTop,
        bottom = paddingBottom,
        left = paddingLeft,
        right = paddingRight;

    if (alignment == null) align = TextAlign.left;
    if (size == null) textSize = UATheme.normalSize();
    if (paddingBottom == null) bottom = 0.0;
    if (paddingTop == null) top = 0.0;
    if (paddingLeft == null) left = 0.0;
    if (paddingRight == null) right = 0.0;
    if (bold == null) isBold = false;
    if (shadow == null) isShadow = false;

    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Text(
        text != null ? text : "",
        textAlign: align,
        style: TextStyle(
          fontSize: textSize,
          fontFamily: 'Nunito',
          color: color,
          fontWeight: isBold ? FontWeight.bold : null,
          shadows: isShadow
              ? [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 1.0,
                    color: Colors.grey,
                  ),
                ]
              : [],
        ),
      ),
    );
  }
}
