class Regions {
  TravelHistory travelHistory;

  Regions({this.travelHistory});

  factory Regions.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson != null)
      return Regions(
        travelHistory: TravelHistory.fromJson(parsedJson['travel_history']),
      );
    else
      return null;
  }
}

class TravelHistory {
  List<Region> region;

  TravelHistory({this.region});

  factory TravelHistory.fromJson(Map<String, dynamic> parsedJson) {
    var dataJson = parsedJson['region'] as List;
    List<Region> regionsList = dataJson.map((i) => Region.fromJson(i)).toList();

    return TravelHistory(region: regionsList);
  }
}

class Region {
  String region_id;
  String region_name;

  Region({
    this.region_id,
    this.region_name,
  });

  factory Region.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson != null)
      return Region(
        region_id: parsedJson['region_id'],
        region_name: parsedJson['region_name'],
      );
    else
      return null;
  }
}
