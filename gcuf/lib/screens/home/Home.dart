import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gcuf/providers/database.dart';

import 'Dash_Board.dart';
import 'My_Drawer.dart';
import 'imageSlider/Image_Slider.dart';

class Home extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final String route = "/home";

  @override
  Widget build(BuildContext context) {
    Provider.of<DataBase>(context).update();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      drawer: LightDrawerPage(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 30,
        title: Text("Home"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Duration future = Duration(seconds: 10);
          return future;
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
