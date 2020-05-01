import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:university/models/AuthModel.dart';
import 'package:university/models/UserModel.dart';
import 'package:university/screens/practice.dart';

class LightDrawerPage extends StatefulWidget {
  @override
  _LightDrawerPageState createState() => _LightDrawerPageState();
}

User user;

class _LightDrawerPageState extends State<LightDrawerPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String email, name;

  final Color primary = Colors.white;

  final Color active = Colors.grey.shade800;

  final Color divider = Colors.grey.shade600;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(LightDrawerPage oldWidget) {
    // Provider.of<NavigationBarModel>(context, listen: false).navigationBar =
    //true;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  getData() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snapshot = await Firestore.instance
        .collection("portal")
        .document(firebaseUser.uid)
        .get();

    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: active,
                    ),
                    onPressed: () {
                      AuthService().signOut();
                    },
                  ),
                ),
                FutureBuilder(
                    future: getData(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            Container(
                                height: 90,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(colors: [
                                      Theme.of(context).accentColor,
                                      Theme.of(context).primaryColor
                                    ])),
                                child: CircleAvatar(
                                  backgroundImage:
                                      userSnapshot.data['url'] == null
                                          ? AssetImage('images/person.jpg')
                                          : CachedNetworkImageProvider(
                                              userSnapshot.data['url']),
                                  radius: 40,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              userSnapshot.data['name'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              userSnapshot.data['email'],
                              style: TextStyle(color: active, fontSize: 16.0),
                            )
                          ],
                        );
                      } else {
                        return Container(
                            height: 140,
                            child: Center(child: CircularProgressIndicator()));
                      }
                    }),
                SizedBox(height: 5.0),
                SizedBox(height: 30.0),
                _buildRow(Icons.home, "Home"),
                _buildDivider(),
                _buildRow(Icons.person_pin, "My profile"),
                _buildDivider(),
                _buildRow(Icons.message, "Messages", showBadge: true),
                _buildDivider(),
                _buildRow(Icons.notifications, "Notifications",
                    showBadge: true),
                _buildDivider(),
                _buildRow(Icons.settings, "Settings"),
                _buildDivider(),
                _buildRow(Icons.email, "Contact us"),
                _buildDivider(),
                _buildRow(Icons.info_outline, "Help"),
                _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(
    IconData icon,
    String title, {
    bool showBadge = false,
  }) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => practice()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: [
          Icon(
            icon,
            color: active,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.deepOrange,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "10+",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
        ]),
      ),
    );
  }
}
