import 'package:flutter/material.dart';

class NoDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Image.asset(
              'images/nodata.png',
              height: 150,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'No Data Found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
