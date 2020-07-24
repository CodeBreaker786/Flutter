class Diagnosis {
  Diagnosis_Checklist diagnosis_checklist;

  Diagnosis({this.diagnosis_checklist});

  factory Diagnosis.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson != null)
      return Diagnosis(
        diagnosis_checklist:
            Diagnosis_Checklist.fromJson(parsedJson['diagnoses_checklist']),
      );
    else
      return null;
  }
}

class Diagnosis_Checklist {
  String triage_api_url;
  QueryResultDetails queryResultDetails;
  List<Diagnoses> diagnoses;
  List<SpecialityUrls> specialtyUrls;

  Diagnosis_Checklist({
    this.triage_api_url,
    this.queryResultDetails,
    this.diagnoses,
    this.specialtyUrls,
  });

  factory Diagnosis_Checklist.fromJson(Map<String, dynamic> parsedJson) {
    print("*************");
    print("HERE");
    var dataJson = parsedJson['diagnoses'] as List;
    print(dataJson);
    List<Diagnoses> diagnosesList =
        dataJson.map((i) => Diagnoses.fromJson(i)).toList();
    print("*************");
    print(diagnosesList[1].specialty);

    var dataJson1 = parsedJson['specialty_urls'] as List;
    List<SpecialityUrls> specialty_urlsList =
        dataJson1.map((i) => SpecialityUrls.fromJson(i)).toList();

    return Diagnosis_Checklist(
      triage_api_url: parsedJson['triage_api_url'],
      queryResultDetails:
          QueryResultDetails.fromJson(parsedJson['query_result_details']),
      diagnoses: diagnosesList,
      specialtyUrls: specialty_urlsList,
    );
  }
}

class QueryResultDetails {
  String age_group;
  String gender;
  String pregnancy;
  String region;
  String specialty_type;
  String query_entered;
  String sorting;
  String total_results_entered;

  QueryResultDetails({
    this.pregnancy,
    this.region,
    this.age_group,
    this.gender,
    this.query_entered,
    this.sorting,
    this.specialty_type,
    this.total_results_entered,
  });

  factory QueryResultDetails.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson != null)
      return QueryResultDetails(
        pregnancy: parsedJson['pregnancy'],
        region: parsedJson['region'],
        age_group: parsedJson['age_group'],
        gender: parsedJson['gender'],
        query_entered: parsedJson['query_entered'],
        sorting: parsedJson['sorting'],
        specialty_type: parsedJson['specialty_type'],
        total_results_entered: parsedJson['total_results_entered'],
      );
    else
      return null;
  }
}

class Diagnoses {
  String diagnosis_id;
  String diagnosis_name;
  String knowledge_window_url;
  String gender;
  String specialty;
  String red_flag;
  String common_diagnosis;
  String snomed_diagnosis_id;
  String icd9_diagnosis_id;
  String icd10_diagnosis_id;

  Diagnoses(
      {this.gender,
      this.common_diagnosis,
      this.diagnosis_id,
      this.diagnosis_name,
      this.knowledge_window_url,
      this.red_flag,
      this.specialty,
      this.snomed_diagnosis_id,
      this.icd10_diagnosis_id,
      this.icd9_diagnosis_id});

  factory Diagnoses.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson != null) {
      return Diagnoses(
        gender: parsedJson['gender'],
        common_diagnosis: parsedJson['common_diagnosis'],
        diagnosis_id: parsedJson['diagnosis_id'],
        diagnosis_name: parsedJson['diagnosis_name'],
        knowledge_window_url: parsedJson['knowledge_window_url'],
        red_flag: parsedJson['red_flag'],
        specialty: parsedJson['specialty'],
        snomed_diagnosis_id: parsedJson['snomed_diagnosis_id'],
        icd10_diagnosis_id: parsedJson['icd10_diagnosis_id'],
        icd9_diagnosis_id: parsedJson['icd9_diagnosis_id'],
      );
    } else
      return null;
  }
}

class SpecialityUrls {
  String specialty;
  String specialty_link;

  SpecialityUrls({
    this.specialty,
    this.specialty_link,
  });

  factory SpecialityUrls.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson != null)
      return SpecialityUrls(
        specialty: parsedJson['specialty'],
        specialty_link: parsedJson['specialty_link'],
      );
    else
      return null;
  }
}
