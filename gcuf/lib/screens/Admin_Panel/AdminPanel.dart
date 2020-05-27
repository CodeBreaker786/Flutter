import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Admin Panel'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              child: Text("jgmgy"),
            ),
            Card(
              child: Text("jgmgy"),
            )
          ],
        ));
  }
}
