 
import 'package:flutter/material.dart';
import 'package:sarasotamemorial/widgets/ualabel.dart';

import '../uatheme.dart';
import 'appsettings.dart';

class UAButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Function onPressed;
  final double paddingTop, paddingLeft, paddingRight, paddingBottom;
  final double size;
  final bool bold;
  final double height;
  final Icon icon;
  final bool enabled;

  UAButton({
    this.icon,
    this.text,
    this.color,
    this.textColor,
    @required this.onPressed,
    this.paddingLeft,
    this.paddingRight,
    this.paddingBottom,
    this.paddingTop,
    this.size,
    this.bold,
    this.height,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    bool isEnabled = enabled;
    double textSize = size;
    bool isBold = bold;
    double btnHeight = height;
    Color textC = textColor;
    Color btnColor = color;
    double top = paddingTop,
        bottom = paddingBottom,
        left = paddingLeft,
        right = paddingRight;
    if (paddingBottom == null) bottom = 0.0;
    if (paddingTop == null) top = 0.0;
    if (paddingLeft == null) left = 0.0;
    if (paddingRight == null) right = 0.0;
    if (textColor == null) textC = Colors.white;
    if (bold == null) isBold = false;
    if (size == null) textSize = UATheme.normalSize();
    if (height == null) btnHeight = 50;
    if (color == null) btnColor = AppSettings.primaryColor;
    if (enabled == null) isEnabled = true;

    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Material(
        color: btnColor,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: btnHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                UALabel(
                  text: text,
                  color: textC,
                  size: textSize,
                  bold: isBold,
                  paddingTop: 5,
                  paddingBottom: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
