import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gcuf/splash/Splash_Screen.dart';

import 'Bottom_Navigation_Bar/Navigation_Screen.dart';
import 'authication/auth.dart';

class Wraper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return AuthPage();
          }
          print(snapshot.data.uid);
          return NavigationScreen();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
