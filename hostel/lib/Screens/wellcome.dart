import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class wellcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Center(child: Image(image: AssetImage("images/house.png"))),
    );
  }

  void sigin() {
    FirebaseAuth.instance.signInAnonymously();
  }
}
