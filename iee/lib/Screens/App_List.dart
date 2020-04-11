import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'Widgets.dart';

class App_List extends StatefulWidget {
  static final RouteName = '/AppList';
  @override
  _App_ListState createState() => _App_ListState();
}

class _App_ListState extends State<App_List> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  static const Apps = [
    "Quiz App",
    "Weather App",
    "IEEE Society",
    "Class portal",
    "Hostel"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Apps"),
        ),
        body: StaggeredGridView.count(
          crossAxisCount: 10,
          children: Apps.map((e) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text_Card(
                    e,
                    Quiz_app,
                    TextStyle(
                        fontSize: 32,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
              )).toList(),
          staggeredTiles: Apps.map(
            (e) => StaggeredTile.extent(10, 120),
          ).toList(),
        ));
  }

  void Quiz_app() async {
    Navigator.pushReplacementNamed(context, '/Question_List');
  }
}
