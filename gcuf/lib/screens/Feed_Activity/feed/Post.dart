import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gcuf/models/Post.dart';
import 'package:gcuf/models/User.dart';
import 'package:gcuf/screens/Feed_Activity/feed/Upload_Post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:gcuf/providers/database.dart';
import './postBuilder.dart';

CollectionReference postsRef = Firestore.instance.collection("posts");

class Post extends StatefulWidget {
  const Post({Key key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
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
        title: Text(
          'News Feed',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 16.0),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Duration(milliseconds: 3000);
        },
        child: _buildFutureBuilder(),
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  // Steam<QuerySnapshot> handleSearch() async {
  //   Stream<QuerySnapshot> users = postsRef.document().snapshots();
  //   //searchResultsFuture = users;
  //   return searchResultsFuture;
  // }

  Widget _buildFutureBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: postsRef.document(user.uid).collection('userPosts').snapshots(),
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          print(snapshots.hasData);
          return Center(
            child: SpinKitWave(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        List<MyPost> searchResults = [];
        searchResults.clear();
        snapshots.data.documents.forEach((doc) {
          MyPost user = MyPost.fromMap(doc);
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
    if (_imageFile != null) {
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => UploadPost(_imageFile)));
    }
  }
}
