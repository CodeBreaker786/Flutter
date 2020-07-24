class CountryData {
  String country_id;
  String country_code;
  String country_code3;
  String country_name;
  String currency_id;
  String timezone_id;
  String latitude;
  String longitude;

	CountryData.fromJsonMap(Map<String, dynamic> map):
		country_id = map["country_id"],
		country_code = map["country_code"],
		country_code3 = map["country_code3"],
		country_name = map["country_name"],
		currency_id = map["currency_id"],
		timezone_id = map["timezone_id"],
		latitude = map["latitude"],
		longitude = map["longitude"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['country_id'] = country_id;
		data['country_code'] = country_code;
		data['country_code3'] = country_code3;
		data['country_name'] = country_name;
		data['currency_id'] = currency_id;
		data['timezone_id'] = timezone_id;
		data['latitude'] = latitude;
		data['longitude'] = longitude;
		return data;
	}
}
