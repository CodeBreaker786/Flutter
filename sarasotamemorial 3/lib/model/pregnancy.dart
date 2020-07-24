class Pregnancies {
  Pregnancy pregnancies;

  Pregnancies({this.pregnancies});

  factory Pregnancies.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson != null)
      return Pregnancies(
        pregnancies: Pregnancy.fromJson(parsedJson['pregnancies']),
      );
    else
      return null;
  }
}

class Pregnancy {
  List<Data> pregnancy;

  Pregnancy({this.pregnancy});

  factory Pregnancy.fromJson(Map<String, dynamic> parsedJson) {
    var dataJson = parsedJson['pregnancy'] as List;
    List<Data> pregnancysList = dataJson.map((i) => Data.fromJson(i)).toList();

    return Pregnancy(pregnancy: pregnancysList);
  }
}

class Data {
  String pregnancy_id;
  String pregnancy_name;

  Data({
    this.pregnancy_id,
    this.pregnancy_name,
  });

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson != null)
      return Data(
        pregnancy_id: parsedJson['pregnancy_id'],
        pregnancy_name: parsedJson['pregnancy_name'],
      );
    else
      return null;
  }
}
