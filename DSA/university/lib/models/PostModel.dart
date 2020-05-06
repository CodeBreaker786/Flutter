import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post(
      {this.ownerId,
      this.photoUrl,
      this.caption,
      this.postId,
      this.time,
      this.date,
      this.ownerName,
      this.loction,
      this.comments,
      this.ownerImgUrl,
      this.likes});
  factory Post.fromMap(DocumentSnapshot snapshot) {
    return Post(
        ownerId: snapshot['ownerId'],
        postId: snapshot['postId'],
        photoUrl: snapshot['photoUrl'],
        ownerName: snapshot['ownerName'],
        time: snapshot['time'],
        date: snapshot['date'],
        loction: snapshot['location'],
        caption: snapshot['caption'],
        likes: snapshot['likes'],
        ownerImgUrl: snapshot['ownerImgUrl'],
        comments: snapshot['commments']);
  }

  String photoUrl;
  String ownerId;
  String ownerName;
  String ownerImgUrl;
  String postId;
  String date;
  String time;
  String loction;
  String caption;
  Map<String, dynamic> likes = {};
  Map<String, dynamic> comments = {};

  Map<String, dynamic> fromUser() {
    return {
      'ownerId': this.ownerId,
      'postId': this.postId,
      'photoUrl': this.photoUrl,
      'time': this.time,
      'date': this.date,
      'ownerName': this.ownerName,
      'loction': this.loction,
      'caption': this.caption,
      'likes': this.likes,
      'comments': this.comments,
      'ownerImgUrl': this.ownerImgUrl,
    };
  }
}
