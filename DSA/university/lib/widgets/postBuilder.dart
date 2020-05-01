import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/models/PostModel.dart';
import 'package:university/widgets/customImageProvider.dart';

class PostBuilder extends StatelessWidget {
  Post post;
  PostBuilder(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ListTile(
              title: Text(post.ownerName),
              subtitle: Text(post.time),
              leading: CircleAvatar(
                backgroundImage: post.ownerImgUrl == null
                    ? AssetImage('images/person.jpg')
                    : CachedNetworkImageProvider(post.ownerImgUrl),
                backgroundColor: Colors.grey,
              ),
              trailing: Icon(Icons.more_horiz),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(post.photoUrl),
                    ),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {}),
                  Text("100"),
                  IconButton(
                      icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
                  Text("100"),
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                      icon: Icon(Icons.bookmark_border), onPressed: () {})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  buildPostHeader() {
    return Container(
      color: Colors.white,
      child: ListTile(
        trailing: Text(post.time),
        leading: CircleAvatar(
          backgroundImage: post.ownerImgUrl == null
              ? AssetImage('images/person.jpg')
              : CachedNetworkImageProvider(post.ownerImgUrl),
          backgroundColor: Colors.grey,
        ),
        title: GestureDetector(
          child: Text(
            post.ownerName,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Text(post.date),
      ),
    );
  }

  buildPostImage() {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          imageViewer(post.photoUrl)
          // Container(
          //     height: 300,
          //     child: PhotoView(imageProvider: NetworkImage(photoUrl)))
          // showHeart
          //     ? Animator(
          //         duration: Duration(milliseconds: 300),
          //         tween: Tween(begin: 0.8, end: 1.4),
          //         curve: Curves.elasticOut,
          //         cycles: 0,
          //         builder: (anim) => Transform.scale(
          //           scale: anim.value,
          //           child: Icon(
          //             Icons.favorite,
          //             size: 80.0,
          //             color: Colors.red,
          //           ),
          //         ),
          //       )
          //     : Text(""),
        ],
      ),
    );
  }
}
