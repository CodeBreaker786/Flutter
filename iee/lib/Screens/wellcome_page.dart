import 'package:flutter/material.dart';

class Wellcome_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Text(
          "Nameless",
          style: TextStyle(
              fontSize: 50.0,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
