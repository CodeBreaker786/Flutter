import 'package:flutter/material.dart';
import 'package:sarasotamemorial/pages/splashscreen.dart';
import 'package:sarasotamemorial/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: MyTheme.setTheme(),
      home: SplashScreen(),
    );
  }
}
