class Post {
  String uid;
  String caption;
  String date;
  String loction;

  Post({this.uid, this.caption, this.date, this.loction});
  factory Post.fromMap() {}
}
