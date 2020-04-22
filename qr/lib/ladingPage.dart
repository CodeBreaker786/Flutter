import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:qr/generate.dart';
import 'package:qr/scanQR.dart';

class lading extends StatefulWidget {
  @override
  _ladingState createState() => _ladingState();
}

class _ladingState extends State<lading> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22),
        visible: true,
        onOpen: () {
          setState(() {
            isOpen = true;
          });
        },
        onClose: () {
          setState(() {
            isOpen = false;
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        curve: Curves.fastOutSlowIn,
        children: [
          // FAB 1

          SpeedDialChild(
              child: Icon(Icons.camera),
              backgroundColor: Theme.of(context).accentColor,
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => scan()));
              },
              label: 'Take photo',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Theme.of(context).accentColor),
          // FAB 2
          SpeedDialChild(
              child: Icon(Icons.photo_library),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => genrate()));
              },
              backgroundColor: Theme.of(context).accentColor,
              label: 'select photo',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Theme.of(context).accentColor)
        ],
      ),
    );
  }
}
