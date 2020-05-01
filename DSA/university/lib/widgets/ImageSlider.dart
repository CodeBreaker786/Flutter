import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:university/models/PostModel.dart';
import 'package:university/screens/post.dart';

class ImageSlider extends StatelessWidget {
  List<Post> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: postsRef.getDocuments(),
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
            Post user = Post.fromMap(doc);
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
          return CarouselSlider.builder(
              enlargeCenterPage: true,
              autoPlay: true,
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                print(index);
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
            alignment: Alignment.bottomCenter,
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
                  searchResults[index].ownerName,
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
