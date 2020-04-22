import 'package:firstproject/models/AuthModel.dart';
import 'package:firstproject/providers/database.dart';
import 'package:firstproject/widgets/DashBoard.dart';
import 'package:firstproject/widgets/ImageSlider.dart';
import 'package:firstproject/widgets/drawer2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static final String route = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<database>(context, listen: false).update();
    super.initState();
  }

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
