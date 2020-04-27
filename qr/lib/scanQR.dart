import 'package:flutter/material.dart';

class scan extends StatefulWidget {
  @override
  _scanState createState() => _scanState();
}

class _scanState extends State<scan> {
  String Result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Result.toString()),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        String cameraScanResult;
        setState(() {
          Result = cameraScanResult;
        });

        print(cameraScanResult.toString());
      }),
    );
  }
}
