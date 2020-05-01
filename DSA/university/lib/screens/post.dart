import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:university/models/PostModel.dart';
import 'package:university/models/UserModel.dart';
import 'package:university/providers/database.dart';
import 'package:university/screens/uploadPost.dart';
import 'package:university/widgets/postBuilder.dart';

CollectionReference postsRef = Firestore.instance.collection("posts");

class Posts extends StatefulWidget {
  const Posts({Key key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  Future<QuerySnapshot> searchResultsFuture;
  File _imageFile;
  bool isOpen = false;
  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<DataBase>(context).currentUser;
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
        child: _buildFutureBuilder(),
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  handleSearch() async {
    Stream<QuerySnapshot> users = postsRef.snapshots();
    //searchResultsFuture = users;
    return searchResultsFuture;
  }

  Widget _buildFutureBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: postsRef.snapshots(),
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          print(snapshots.hasData);
          return Center(
            child: SpinKitWave(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        List<Post> searchResults = [];
        searchResults.clear();
        snapshots.data.documents.forEach((doc) {
          Post user = Post.fromMap(doc);
          searchResults.add(user);
        });
        if (searchResults.isEmpty) {
          return Center(
            child: Text(
              "No Post Available Yet",
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        return ListView(
          children: <Widget>[
            ...searchResults.map((doc) {
              return PostBuilder(doc);
            }).toList(),
          ],
        );
      },
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
