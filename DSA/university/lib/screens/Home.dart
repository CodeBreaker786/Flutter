import 'package:university/models/AuthModel.dart';
import 'package:university/providers/database.dart';
import 'package:university/widgets/DashBoard.dart';
import 'package:university/widgets/ImageSlider.dart';
import 'package:university/widgets/drawer2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static final String route = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      drawer: LightDrawerPage(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () async {
              AuthService().signOut();
            },
          )
        ],
        elevation: 30,
        title: Text("Home"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Duration(milliseconds: 30000);
        },
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ImageSlider(),
                DashBoard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
