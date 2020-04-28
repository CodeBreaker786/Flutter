import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:university/screens/uploadPost.dart';

class Posts extends StatefulWidget {
  const Posts({Key key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  File _imageFile;
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text('News Feed'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Duration(milliseconds: 30000);
        },
        child: FutureBuilder(builder: (context, index) {
          return Container(
            child: Text("data"),
          );
        }),
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  Widget _buildFloatingButton() {
    return SpeedDial(
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
              _pickImage(ImageSource.camera);
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
              _pickImage(ImageSource.gallery);
            },
            backgroundColor: Theme.of(context).accentColor,
            label: 'select photo',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Theme.of(context).accentColor)
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(
        source: source, maxHeight: 675, maxWidth: 960);

    setState(() {
      _imageFile = selected;
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UploadScreen(_imageFile)));
  }
}
