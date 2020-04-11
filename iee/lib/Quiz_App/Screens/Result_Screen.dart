import 'package:flutter/material.dart';
import 'package:iee/Screens/Widgets.dart';

class Result_Screen extends StatelessWidget {
  static final RouteName = '/ResultScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Score"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Text_Card(
                  "Score",
                  null,
                  TextStyle(
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold))),
        ),
      ),
    );
  }
}
