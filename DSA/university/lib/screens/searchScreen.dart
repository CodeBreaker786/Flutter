import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:university/models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:university/screens/ViewProfile.dart';

TextEditingController searchController = TextEditingController();

class SearchScreen extends StatefulWidget {
  static final String route = "/detail";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  CollectionReference ref = Firestore.instance.collection("portal");
  Future<QuerySnapshot> searchResultsFuture;
  bool isLoding = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBackgroundStack();
  }

  Widget _buildBackgroundStack() {
    return Stack(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor,
          //color: Colors.grey,
          child: isLoding
              ? _buildFutureBuilder()
              : Center(
                  child: Center(
                    child: Container(
                        child: Icon(
                      Icons.search,
                      size: 120,
                      color: Theme.of(context).primaryColor,
                    )),
                  ),
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
                    onChanged: onQueryChanged,
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

  Widget _buildFutureBuilder() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          return Center(
            child: SpinKitWave(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        List<User> searchResults = [];
        searchResults.clear();
        snapshots.data.documents.forEach((doc) {
          print(doc.toString());
          User user = User().fromMap(doc);
          searchResults.add(user);
        });
        if (searchResults.isEmpty) {
          return _buildOnNoData();
        }
        return _buildOnData(searchResults);
      },
    );
  }

  Widget _buildOnData(searchResults) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 120,
        ),
        ...searchResults.map((doc) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileViewer(doc.url, doc.name, doc.email)));
            },
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: CircleAvatar(
                    backgroundImage: doc.url != null
                        ? CachedNetworkImageProvider(doc.url)
                        : AssetImage('images/person.jpg')),
                title: Text(doc.name),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildOnNoData() {
    return Center(
        child: Text(
      "No Post Available Yet",
      style: TextStyle(fontSize: 20),
    ));
  }

  handleSearch(String query) {
    Future<QuerySnapshot> users =
        ref.where("name", isGreaterThanOrEqualTo: query).getDocuments();
    setState(() {
      searchResultsFuture = users;
    });
  }

  onQueryChanged(query) {
    handleSearch(query);
    if (query != "") {
      setState(() {
        isLoding = true;
      });
    } else {
      setState(() {
        isLoding = false;
      });
    }
  }
}
