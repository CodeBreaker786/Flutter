import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gcuf/customPackages/constantVariable.dart';
import 'package:gcuf/models/Post.dart';

class ImageSlider extends StatelessWidget {
  final List<MyPost> searchResults = [];

  Future<QuerySnapshot> getImages() async {
    // FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Future<QuerySnapshot> documentSnapshot =
        portalRef.document('user.uid').collection('userPosts').getDocuments();
    return documentSnapshot;
  }

  @override
  Widget build(BuildContext context) {
    // User user = Provider.of<DataBase>(context).currentUser;
    return FutureBuilder(
        future: getImages(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Container(
              height: 238,
              child: Center(
                child: SpinKitWave(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          }

          searchResults.clear();
          snapshots.data.documents.forEach((doc) {
            print(doc.toString());
            MyPost user = MyPost.fromMap(doc);
            searchResults.add(user);
          });
          if (searchResults.isEmpty) {
            return Container(
              child: Center(
                child: Text(
                  "No Image is available Yet",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          }
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return _buildSliderCard(index);
              });
        });
  }

  Widget _buildSliderCard(int index) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 10,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        searchResults[index].photoUrl),
                    fit: BoxFit.cover)),
            child: Card(
              color: Colors.white30,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  'Society Name',
                  //searchResults[index].ownerName,
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ));
  }
}
