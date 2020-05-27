import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/code.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ));
  }
}
