import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/applogo.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ));
  }

  void verifyAuthication() async => await Future.wait([]).then((value) {});
}

// Stream<User> getAuthication() {
//   return AuthService().user;
// }
