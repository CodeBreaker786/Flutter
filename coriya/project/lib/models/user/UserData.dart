class UserData {
  String user_id;
  String first_name;
  String last_name;
  String user_email;
  String user_phone;
  String user_role_id;
  String user_pass;
  String user_profile_pic;
  String active;
  String banned;
  String user_from;
  String subscription_id;
  Object subscription_start;
  Object subscription_end;

  UserData.fromJsonMap(Map<String, dynamic> map)
      : user_id = map["user_id"],
        first_name = map["first_name"],
        last_name = map["last_name"],
        user_email = map["user_email"],
        user_phone = map["user_phone"],
        user_role_id = map["user_role_id"],
        user_pass = map["user_pass"],
        user_profile_pic = map["user_profile_pic"],
        active = map["active"],
        banned = map["banned"],
        user_from = map["user_from"],
        subscription_id = map["subscription_id"],
        subscription_start = map["subscription_start"],
        subscription_end = map["subscription_end"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = user_id;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['user_email'] = user_email;
    data['user_phone'] = user_phone;
    data['user_role_id'] = user_role_id;
    data['user_pass'] = user_pass;
    data['user_profile_pic'] = user_profile_pic;
    data['active'] = active;
    data['banned'] = banned;
    data['user_from'] = user_from;
    data['subscription_id'] = subscription_id;
    data['subscription_start'] = subscription_start;
    data['subscription_end'] = subscription_end;
    return data;
  }
}
