class AgeGroups {
  AgeGroup1 ageGroup1;
  AgeGroups({this.ageGroup1});

  factory AgeGroups.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson != null)
      return AgeGroups(
        ageGroup1: AgeGroup1.fromJson(parsedJson['age_groups']),
      );
    else
      return null;
  }
}

class AgeGroup1 {
  List<AgeGroup> ageGroup;

  AgeGroup1({this.ageGroup});

  factory AgeGroup1.fromJson(Map<String, dynamic> parsedJson) {
    var dataJson = parsedJson['age_group'] as List;
    List<AgeGroup> ageGroupsList =
        dataJson.map((i) => AgeGroup.fromJson(i)).toList();

    return AgeGroup1(ageGroup: ageGroupsList);
  }
}

class AgeGroup {
  String agegroup_id;
  String ordinal;
  String name;
  String yr_from;
  String yr_to;
  String branch;
  String can_conceive;

  AgeGroup(
      {this.name,
      this.agegroup_id,
      this.branch,
      this.can_conceive,
      this.ordinal,
      this.yr_from,
      this.yr_to});

  factory AgeGroup.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson != null)
      return AgeGroup(
        name: parsedJson['name'],
        agegroup_id: parsedJson['agegroup_id'],
        branch: parsedJson['branch'],
        can_conceive: parsedJson['can_conceive'],
        ordinal: parsedJson['ordinal'],
        yr_from: parsedJson['yr_from'],
        yr_to: parsedJson['yr_to'],
      );
    else
      return null;
  }
}
