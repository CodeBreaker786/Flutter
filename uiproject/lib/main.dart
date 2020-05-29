import 'package:flutter/material.dart';
import 'package:uiproject/bottom_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColorDark: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BottomNaviBar());
  }
}
