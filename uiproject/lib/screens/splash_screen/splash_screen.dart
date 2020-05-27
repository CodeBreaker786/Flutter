import 'package:flutter/material.dart';
import 'package:uiproject/colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UiColors.darkblue,
        body: Center(child: Image.asset('icons/Logo.png')));
  }
}
