class UserRole {
  String role_id;
  String role;

  UserRole({this.role_id, this.role});

  UserRole.fromJsonMap(Map<String, dynamic> map)
      : role_id = map["role_id"],
        role = map["role"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role_id'] = role_id;
    data['role'] = role;
    return data;
  }
}
