import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:university/screens/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      // textTheme: GoogleFonts.dancingScriptTextTheme(
      //   Theme.of(context).textTheme,

      home: SplashScreen(),
    );
  }
}
