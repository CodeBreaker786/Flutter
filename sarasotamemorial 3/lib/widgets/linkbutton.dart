import 'package:flutter/material.dart';
import 'package:sarasotamemorial/theme.dart';

class LinkButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;

  LinkButton({this.title, this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(50),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontFamily: 'Lexend',
          fontWeight: FontWeight.bold,
          fontSize: MyTheme.normalTextSize(),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
