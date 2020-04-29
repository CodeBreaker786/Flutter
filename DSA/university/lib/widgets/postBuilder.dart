import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:university/models/PostModel.dart';
import 'package:university/widgets/customImageProvider.dart';

class PostBuilder extends StatelessWidget {
  Post post;
  PostBuilder(this.post);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildPostHeader(),
        buildPostImage(),
      ],
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
