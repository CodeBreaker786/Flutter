
class PaymentCallbackData {
  String user_id;
  String first_name;
  String last_name;
  String transaction_id;
  String subscription_name;
  String subscription_cost;
  String subscription_duration;
  String subscription_start;
  String subscription_end;

	PaymentCallbackData.fromJsonMap(Map<String, dynamic> map):
		user_id = map["user_id"],
		first_name = map["first_name"],
		last_name = map["last_name"],
		transaction_id = map["transaction_id"],
		subscription_name = map["subscription_name"],
		subscription_cost = map["subscription_cost"],
		subscription_duration = map["subscription_duration"],
		subscription_start = map["subscription_start"],
		subscription_end = map["subscription_end"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['user_id'] = user_id;
		data['first_name'] = first_name;
		data['last_name'] = last_name;
		data['transaction_id'] = transaction_id;
		data['subscription_name'] = subscription_name;
		data['subscription_cost'] = subscription_cost;
		data['subscription_duration'] = subscription_duration;
		data['subscription_start'] = subscription_start;
		data['subscription_end'] = subscription_end;
		return data;
	}
}
