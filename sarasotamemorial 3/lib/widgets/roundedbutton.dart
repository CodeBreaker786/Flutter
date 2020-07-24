import 'package:flutter/material.dart';
import 'package:sarasotamemorial/theme.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;

  RoundedButton({this.title, this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(50),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Lexend',
          fontSize: MyTheme.normalTextSize(),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
