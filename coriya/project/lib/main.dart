import 'package:avalinks/screen/SplashScreen.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'AvaLinks',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: new Color(0xFF72adff),
        primaryColorDark: new Color(0xFF287aed),
        accentColor: new Color(0xFFFF4081),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: TextTheme(
                title: TextStyle(color: Colors.white, fontSize: 20.0)),
            actionsIconTheme: IconThemeData(color: Colors.white)),
        fontFamily: 'AvenirNext',
      ),
      home: SplashScreen(),
      routes: routes,
    );
  }
}
