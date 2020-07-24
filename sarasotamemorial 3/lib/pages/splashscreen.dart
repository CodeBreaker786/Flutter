import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sarasotamemorial/pages/home.dart';
import 'package:sarasotamemorial/theme.dart';
import 'package:sarasotamemorial/widgets/customtext.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void handleTimeout() async {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (BuildContext context) => new Home()));
  }

  startTimeout() async {
    var duration = const Duration(seconds: 1);
    return new Timer(duration, handleTimeout);
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    MyTheme.init(context);

    return Scaffold(
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image(
              image: new AssetImage("assets/images/icon.jpg"),
              width: 200.0,
              height: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomText(
                title: MyTheme.appName,
                size: MyTheme.largeText(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
