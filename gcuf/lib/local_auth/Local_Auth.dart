import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class Local_Auth extends StatefulWidget {
  @override
  _Local_AuthState createState() => _Local_AuthState();
}

class _Local_AuthState extends State<Local_Auth> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Center(
          child: Icon(
        Icons.fingerprint,
        size: 50,
      )),
    );
  }
}
