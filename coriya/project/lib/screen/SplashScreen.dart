import 'dart:async';

import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("images/img_splash_bg.jpg"),
                fit: BoxFit.fill)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(new Duration(seconds: 3), () async {
      String userId = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
      if (userId == null || userId.isEmpty) {
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        String userRoleId =
            await PrefsUtils.getStringPreference(AppConstant.USER_ROLE_ID);
        if (userRoleId == AppConstant.USER_ROLE_ID_VAL) {
          Navigator.of(context).pushReplacementNamed('/user_home');
        } else if (userRoleId == AppConstant.VENDOR_ROLE_ID_VAL) {
          Navigator.of(context).pushReplacementNamed('/vendor_home');
        } else {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      }
    });
  }
}
