import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsaa/models/UserModel.dart';
import 'package:dsaa/providers/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  static final String route = "/detail";
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  CollectionReference ref = Firestore.instance.collection("portal");
  FirebaseUser user;
  User u;
  @override
  void initState() {
    show();

    super.initState();
  }

  show() async {
    user = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    u = Provider.of<database>(context, listen: false).user;

    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          title: Text("Details"),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: ref.snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return Center(
                  child: SpinKitWave(
                color: Theme.of(context).primaryColor,
              ));
            }

            return ListView(
              children: snapshots.data.documents.map((doc) {
                return Card(
                  elevation: 10,
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundImage: doc['url'] != null
                            ? CachedNetworkImageProvider(doc['url'])
                            : AssetImage('images/person.jpg')),
                    title: Text(doc["name"]),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
