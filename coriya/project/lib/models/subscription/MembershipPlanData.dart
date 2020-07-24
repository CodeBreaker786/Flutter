class MembershipPlanData {
  String price_table_id;
  String price_table_title;
  String price_table_cost;
  String offer_duration;
  String offer_type;
  String price_table_top;

  MembershipPlanData.fromJsonMap(Map<String, dynamic> map)
      : price_table_id = map["price_table_id"],
        price_table_title = map["price_table_title"],
        price_table_cost = map["price_table_cost"],
        offer_duration = map["offer_duration"],
        offer_type = map["offer_type"],
        price_table_top = map["price_table_top"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price_table_id'] = price_table_id;
    data['price_table_title'] = price_table_title;
    data['price_table_cost'] = price_table_cost;
    data['offer_duration'] = offer_duration;
    data['offer_type'] = offer_type;
    data['price_table_top'] = price_table_top;
    return data;
  }
}
