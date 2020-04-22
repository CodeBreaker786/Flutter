import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstproject/models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

TextEditingController searchController = TextEditingController();

class Details extends StatefulWidget {
  static final String route = "/detail";

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  CollectionReference ref = Firestore.instance.collection("portal");
  Future<QuerySnapshot> searchResultsFuture;
  bool isLoding = false;

  @override
  void initState() {
    super.initState();
  }

  handleSearch(String query) {
    Future<QuerySnapshot> users =
        ref.where("name", isGreaterThanOrEqualTo: query).getDocuments();
    setState(() {
      searchResultsFuture = users;
    });
  }

  onchanged(query) {
    handleSearch(query);
    if (searchController.text != "") {
      setState(() {
        isLoding = true;
      });
    } else {
      setState(() {
        isLoding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor,
          child: FutureBuilder(
            future: searchResultsFuture,
            builder: (context, snapshots) {
              if (!snapshots.hasData) {
                return Center(
                    child: SpinKitWave(
                  color: Theme.of(context).primaryColor,
                ));
              }
              List<User> searchResults = [];
              searchResults.clear();
              snapshots.data.documents.forEach((doc) {
                print(doc.toString());
                User user = User().fromMap(doc);
                searchResults.add(user);
              });
              return ListView(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  ...searchResults.map((doc) {
                    return Card(
                      elevation: 10,
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage: doc.url != null
                                ? CachedNetworkImageProvider(doc.url)
                                : AssetImage('images/person.jpg')),
                        title: Text(doc.name),
                      ),
                    );
                  }).toList(),
                ],
              );
            },
          ),
        ),
        Positioned(
          top: 60,
          right: 15,
          left: 15,
          child: Card(
            child: Row(
              children: <Widget>[
//                IconButton(
//                  splashColor: Colors.grey,
//                  icon: Icon(Icons.menu),
//                  onPressed: () {},
//                ),
                Expanded(
                  child: TextField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    onChanged: onchanged,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Search..."),
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.only(right: 8.0),
//                  child: CircleAvatar(
//                    backgroundColor: Colors.deepPurple,
//                    child: Text('RD'),
//                  ),
//                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
