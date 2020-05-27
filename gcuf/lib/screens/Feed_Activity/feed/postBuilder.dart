import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcuf/customPackages/constantVariable.dart';
import 'package:gcuf/models/Post.dart';
import 'package:gcuf/screens/Feed_Activity/comments/comments.dart';
import 'package:gcuf/widgets/Image_Loder.dart';
import 'package:shimmer/shimmer.dart';

class PostBuilder extends StatefulWidget {
  PostBuilder(this.post);
  MyPost post;

  @override
  _PostBuilderState createState() => _PostBuilderState();
}

class _PostBuilderState extends State<PostBuilder> {
  bool headerLoding = true;

  bool imageLoding = true;
  bool isLiked;

  bool footerLoding = true;
  int likesCount = 0;
  bool showHeart = false;

  @override
  Widget build(BuildContext context) {
    isLiked = (widget.post.likes[widget.post.ownerId] == true);
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

  Stream<DocumentSnapshot> getData() {
    return portalRef.document(widget.post.ownerId).snapshots();
  }

  Widget _buildPostHeader() {
    return StreamBuilder<DocumentSnapshot>(
      stream: getData(),
      builder: (context, querySnapshot) {
        if (!querySnapshot.hasData) {
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
            backgroundImage: querySnapshot.data['url'] == null
                ? AssetImage('images/person.jpg')
                : CachedNetworkImageProvider(querySnapshot.data['url']),
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
    return StreamBuilder(
      stream: getData(),
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
              child: MyImage.from(
                widget.post.photoUrl,
                borderRadius: BorderRadius.circular(20),
              ),
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
              icon: isLiked != true
                  ? Icon(Icons.favorite_border)
                  : Icon(
                      Icons.favorite,
                      color: Colors.red,
                      // color: Colors.redAccent,
                    ),
              onPressed: () {
                handlePostrLikes();
              }),
          Text(widget.post.likes == null
              ? '0'
              : getLikeCount(widget.post.likes).toString()),
          IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Comments()));
              }),
          Text(widget.post.comments == null
              ? '0'
              : getCommentsCount(widget.post.comments).toString()),
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
      await postRef
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
      print(widget.post.ownerId);
      print(widget.post.postId);

      await postRef
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

int getCommentsCount(Map comments) {
  if (comments == null) {
    return 0;
  }
  int count = 0;
  // if the key is explicitly set to true, add a like
  comments.values.forEach((val) {
    if (val == true) {
      count += 1;
    }
  });
  return count;
}
