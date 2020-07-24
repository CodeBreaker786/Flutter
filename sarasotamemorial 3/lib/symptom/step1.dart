import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sarasotamemorial/model/agegroups.dart';
import 'package:sarasotamemorial/model/regions.dart';
import 'package:sarasotamemorial/model/user.dart';
import 'package:sarasotamemorial/networking.dart';
import 'package:sarasotamemorial/symptom/step2.dart';
import 'package:sarasotamemorial/theme.dart';
import 'package:sarasotamemorial/widgets/customtext.dart';
import 'package:sarasotamemorial/widgets/roundedbutton.dart';

class Step1 extends StatefulWidget {
  @override
  _Step1State createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  bool isLoading = true;
  int isMale = 1;
  int isPregnant = 0;
  AgeGroups ageGroups;
  Regions regions;
  String selectedAge = "";
  String selectedRegion = "";
  String selectedRegionId = "0";
  String ageGroupId = "0";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    ageGroups = await NetworkHelper.getAgeGroups();
    selectedAge = ageGroups.ageGroup1.ageGroup[0].name;

    regions = await NetworkHelper.getRegions();
    selectedRegion = regions.travelHistory.region[0].region_name;

    print(selectedRegion);

    isLoading = false;
    setState(() {});

    //print(regions.travelHistory.region[0].region_name);

    //Pregnancies pregnancies = await NetworkHelper.getPregnancies();
    //print(pregnancies.pregnancies.pregnancy[0].pregnancy_name);

    //Diagnosis diagnosis = await NetworkHelper.getDiagnosis();
    //print(diagnosis.diagnosis_checklist.diagnoses[0].diagnosis_name);
    //print(diagnosis.diagnosis_checklist.specialtyUrls[0].specialty);
    //print(diagnosis.diagnosis_checklist.queryResultDetails.age_group);
  }

  @override
  Widget build(BuildContext context) {
    MyTheme.init(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          title: 'Symptom Checker',
          size: MyTheme.headingSize(),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CustomText(
                      title: 'Enter your information',
                      size: MyTheme.largeText(),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    height: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: DropdownButton<String>(
                      value: selectedAge,
                      hint: CustomText(
                        title: selectedAge,
                        size: MyTheme.normalTextSize(),
                        color: Colors.grey.shade500,
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey.shade500,
                      ),
                      underline: Container(),
                      isExpanded: true,
                      items: ageGroups != null
                          ? ageGroups.ageGroup1.ageGroup
                              .map(
                                (map) => DropdownMenuItem(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: CustomText(
                                      title: map.name +
                                          " (" +
                                          map.yr_from +
                                          "-" +
                                          map.yr_to +
                                          ")",
                                      size: MyTheme.normalTextSize(),
                                    ),
                                  ),
                                  value: map.name,
                                ),
                              )
                              .toList()
                          : [],
                      onChanged: (String val) {
                        selectedAge = val;
                        setState(() {
                          selectedAge = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey.shade200,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RadioListTile(
                            value: 0,
                            groupValue: isMale,
                            onChanged: (newValue) =>
                                setState(() => isMale = newValue),
                            title: CustomText(
                              title: 'Female',
                              color: Colors.black,
                              size: MyTheme.normalTextSize(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: 1,
                            groupValue: isMale,
                            onChanged: (newValue) =>
                                setState(() => isMale = newValue),
                            title: CustomText(
                              title: 'Male',
                              color: Colors.black,
                              size: MyTheme.normalTextSize(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isMale == 0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          CustomText(
                            title: 'Are you Pregnant?',
                            color: Colors.black,
                            size: MyTheme.normalTextSize(),
                          ),
                          Expanded(
                            child: RadioListTile(
                              value: 1,
                              groupValue: isPregnant,
                              onChanged: (newValue) =>
                                  setState(() => isPregnant = newValue),
                              title: CustomText(
                                title: 'Yes',
                                color: Colors.black,
                                size: MyTheme.normalTextSize(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              value: 0,
                              groupValue: isPregnant,
                              onChanged: (newValue) =>
                                  setState(() => isPregnant = newValue),
                              title: CustomText(
                                title: 'No',
                                color: Colors.black,
                                size: MyTheme.normalTextSize(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey.shade200,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: DropdownButton<String>(
                      value: selectedRegion,
                      hint: CustomText(
                        title: selectedRegion,
                        size: MyTheme.normalTextSize(),
                        color: Colors.grey.shade500,
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey.shade500,
                      ),
                      underline: Container(),
                      isExpanded: true,
                      items: regions != null
                          ? regions.travelHistory.region
                              .map(
                                (map) => DropdownMenuItem(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: CustomText(
                                      title: map.region_name,
                                      size: MyTheme.normalTextSize(),
                                    ),
                                  ),
                                  value: map.region_name,
                                ),
                              )
                              .toList()
                          : [],
                      onChanged: (String val) {
                        selectedRegion = val;
                        setState(() {
                          selectedRegion = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    height: 1,
                  ),
                ],
              )),
            ),
            Container(
              color: Colors.grey.shade300,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: RoundedButton(
                      onPressed: () {
                        getRegionId();
                        getAgeGroupId();
                        User user = new User();
                        user.gender = isMale == 1 ? "m" : "f";
                        user.pregnant = isPregnant == 1 ? "y" : "n";
                        user.age = ageGroupId;
                        user.region = selectedRegionId;
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Step2(user)));
                      },
                      title: 'Next step',
                      color: Color(0xff639EC7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getRegionId() {
    for (int i = 0; i < regions.travelHistory.region.length; i++) {
      if (selectedRegion == regions.travelHistory.region[i].region_name) {
        selectedRegionId = regions.travelHistory.region[i].region_id;
        break;
      }
    }
  }

  getAgeGroupId() {
    for (int i = 0; i < ageGroups.ageGroup1.ageGroup.length; i++) {
      if (selectedAge == ageGroups.ageGroup1.ageGroup[i].name) {
        ageGroupId = ageGroups.ageGroup1.ageGroup[i].agegroup_id;
        break;
      }
    }
  }
}
