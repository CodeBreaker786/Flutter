import 'package:flutter/material.dart';
import 'package:hostel/Screens/Home_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: Colors.white30,
          primaryColor: Colors.cyan,
          cardColor: Colors.white70),
      debugShowCheckedModeBanner: false,
      home: Dash_Baord(),
      routes: {},
    );
  }
}
