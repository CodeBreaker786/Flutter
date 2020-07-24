import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sarasotamemorial/model/agegroups.dart';
import 'package:sarasotamemorial/model/diagnosis.dart';
import 'package:sarasotamemorial/model/pregnancy.dart';
import 'package:sarasotamemorial/model/regions.dart';
import 'package:sarasotamemorial/model/user.dart';

class NetworkHelper {
  static String key = "824Kq4x8sDz54AF0o753g3eQpSaT8T1X";

  static getAgeGroups() async {
    String url =
        'https://apiscsandbox.isabelhealthcare.com/v2/age_groups?language=english&web_service=json';

    var response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: key});

    print("************ RESPONSE BODY ***********");
    print("${response.body}");

    final data = json.decode(response.body);
    AgeGroups ageGroups = new AgeGroups.fromJson(data);
    print(data);
    return ageGroups;
  }

  static getRegions() async {
    String url =
        'https://apiscsandbox.isabelhealthcare.com/v2/regions?language=english&web_service=json';

    var response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: key});

    print("************ RESPONSE BODY ***********");
    print("${response.body}");

    final data = json.decode(response.body);
    Regions region = new Regions.fromJson(data);
    print(data);
    return region;
  }

  static getPregnancies() async {
    String url =
        'https://apiscsandbox.isabelhealthcare.com/v2/pregnancies?language=english&web_service=json';

    var response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: key});

    print("************ RESPONSE BODY ***********");
    print("${response.body}");

    final data = json.decode(response.body);
    Pregnancies pregnancies = new Pregnancies.fromJson(data);
    print(data);
    return pregnancies;
  }

  static getDiagnosis(User user) async {
    String url =
        'https://apiscsandbox.isabelhealthcare.com/v2/ranked_differential_diagnoses?' +
            'specialties=28' +
            '&dob=${user.age}' +
            '&sex=${user.gender}' +
            '&pregnant=${user.pregnant}' +
            '&region=${user.region}' +
            '&querytext=${user.symptoms}' +
            '&suggest=Suggest+Differential+Diagnosis' +
            '&flag=sortbyRW_advanced' +
            '&searchType=0' +
            '&web_service=json';

    print(url);
    var response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: key});

    print("************ RESPONSE BODY ***********");
    print("${response.body}");

    final data = json.decode(response.body);
    Diagnosis diagnosis = new Diagnosis.fromJson(data);
    print(data);
    return diagnosis;
  }

  static getTriageScore(User user) async {
    String url =
        'https://apiscsandbox.isabelhealthcare.com/v2/triage_score?dx=1'
        '&age=${user.age}'
        '&sex=${user.gender}'
        '&region=${user.region}'
        '&text=${user.symptoms}'
        '&pregnancy=${user.pregnant}'
        '&Q1=${user.q1}'
        '&Q2=${user.q2}'
        '&Q3=${user.q3}'
        '&Q4=${user.q4}'
        '&Q5=${user.q5}'
        '&Q6=${user.q6}'
        '&Q7=${user.q7}'
        '&web_service=json';

    print(url);
    var response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: key});

    print("************ RESPONSE BODY ***********");
    print("${response.body}");

    String a = response.body;
    var s = json.decode(a);
    print(s['where_to_now']['triage_score']);
    if (s != null)
      return s['where_to_now']['triage_score'];
    else
      return null;
  }
}
