import 'package:flutter/material.dart';

class Drewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
              accountName: Text("Nameless"),
              accountEmail: Text("Limitless699@gmail.com"))
        ],
      ),
    );
  }
}
