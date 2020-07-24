import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation {
  static open(BuildContext context, Widget widget) {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  static closeOpen(BuildContext context, Widget widget) {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  static close(BuildContext context) {
    Navigator.pop(context);
  }
}
