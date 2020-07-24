class BlogData {
  String blog_id;
  String blog_title;
  String blog_body;
  String user_role_id;
  String author_id;
  String blog_status;
  String blog_post_date;

  BlogData.fromJsonMap(Map<String, dynamic> map)
      : blog_id = map["blog_id"],
        blog_title = map["blog_title"],
        blog_body = map["blog_body"],
        user_role_id = map["user_role_id"],
        author_id = map["author_id"],
        blog_status = map["blog_status"],
        blog_post_date = map["blog_post_date"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blog_id'] = blog_id;
    data['blog_title'] = blog_title;
    data['blog_body'] = blog_body;
    data['user_role_id'] = user_role_id;
    data['author_id'] = author_id;
    data['blog_status'] = blog_status;
    data['blog_post_date'] = blog_post_date;
    return data;
  }
}
