import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:university/models/PostModel.dart';
import 'package:university/screens/uploadPost.dart';

class PostBuilder extends StatefulWidget {
  PostBuilder(this.post);
  Post post;

  @override
  _PostBuilderState createState() => _PostBuilderState();
}

class _PostBuilderState extends State<PostBuilder> {
  bool header_Loding = true;

  bool image_Loding = true;

  bool footer_Loding = true;
  int likesCount = 0;
  bool showHeart = false;

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
            _buildPostHeader(),
            _buildPostImage(context),
            _buildPostFooter(),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 15),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: widget.post.caption == null
                      ? Container()
                      : Text(widget.post.caption)),
            ),
          ],
        ),
      ),
    );
  }

  Future getData() async {
    return await Duration(seconds: 10);
  }

  Widget _buildPostHeader() {
    return FutureBuilder(
      future: getData(),
      builder: (context, data) {
        if (!data.hasData) {
          return Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            height: 12,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(35)),
                          ),
                        ),
                        Container(
                          height: 10,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(35)),
                        )
                      ],
                    )
                  ],
                ),
              ));
        }

        return ListTile(
          title: Text(widget.post.ownerName),
          subtitle: Text(widget.post.time),
          leading: CircleAvatar(
            backgroundImage: widget.post.ownerImgUrl == null
                ? AssetImage('images/person.jpg')
                : CachedNetworkImageProvider(widget.post.ownerImgUrl),
            backgroundColor: Colors.grey,
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.more_horiz,
              ),
              onPressed: () {}),
        );
      },
    );
  }

  Widget _buildPostImage(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, data) {
        if (!data.hasData) {
          return Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ));
        }
        return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(widget.post.photoUrl),
                  ),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: Icon(
                showHeart != true ? Icons.favorite_border : Icons.favorite,
                // color: Colors.redAccent,
              ),
              onPressed: () {
                handlePostrLikes();
              }),
          Text(widget.post.likes == null
              ? '0'
              : getLikeCount(widget.post.likes).toString()),
          IconButton(icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
          Text(widget.post.comments == null
              ? '0'
              : widget.post.comments.length.toString()),
          Expanded(
            child: Container(),
          ),
          IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {})
        ],
      ),
    );
  }

  int getLikeCount(likes) {
    // if no likes, return 0
    if (likes == null) {
      return 0;
    }
    int count = 0;
    // if the key is explicitly set to true, add a like
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  Future handlePostrLikes() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    bool _isLiked = widget.post.likes[user.uid] == true;
    print(_isLiked);

    if (_isLiked) {
      await portalRef
          .document(widget.post.ownerId)
          .collection('userPosts')
          .document(widget.post.postId)
          .updateData({'likes.${user.uid}': false});

      setState(() {
        likesCount -= 1;
        _isLiked = false;
        showHeart = false;
        widget.post.likes[user.uid] = false;
      });
    } else if (!_isLiked) {
      await portalRef
          .document(widget.post.ownerId)
          .collection('userPosts')
          .document(widget.post.postId)
          .updateData({'likes.${user.uid}': true});
      //addLikeToActivityFeed();
      setState(() {
        likesCount += 1;
        _isLiked = true;
        widget.post.likes[user.uid] = true;
        showHeart = true;
      });
      // Timer(Duration(milliseconds: 500), () {
      //   setState(() {
      //     showHeart = false;
      //   });
      // });
    }
  }
}
