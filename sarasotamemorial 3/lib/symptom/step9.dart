import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sarasotamemorial/model/user.dart';
import 'package:sarasotamemorial/symptom/step10.dart';
import 'package:sarasotamemorial/symptom/step7.dart';
import 'package:sarasotamemorial/symptom/step8.dart';
import 'package:sarasotamemorial/theme.dart';
import 'package:sarasotamemorial/widgets/customtext.dart';
import 'package:sarasotamemorial/widgets/roundedbutton.dart';

class Step9 extends StatefulWidget {
  final User user;

  Step9(this.user);

  @override
  _Step9State createState() => _Step9State();
}

class _Step9State extends State<Step9> {
  bool isLoading = true;
  int symptomsTime = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
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
                        title:
                            'Do you feel better after taking medication for your symptoms?',
                        size: MyTheme.largeText(),
                      ),
                    ),
                    RadioListTile(
                      value: 1,
                      groupValue: symptomsTime,
                      onChanged: (newValue) =>
                          setState(() => symptomsTime = newValue),
                      title: CustomText(
                        title: 'Not taking any',
                        color: Colors.black,
                        size: MyTheme.normalTextSize(),
                      ),
                    ),
                    RadioListTile(
                      value: 2,
                      groupValue: symptomsTime,
                      onChanged: (newValue) =>
                          setState(() => symptomsTime = newValue),
                      title: CustomText(
                        title: 'Yes',
                        color: Colors.black,
                        size: MyTheme.normalTextSize(),
                      ),
                    ),
                    RadioListTile(
                      value: 3,
                      groupValue: symptomsTime,
                      onChanged: (newValue) =>
                          setState(() => symptomsTime = newValue),
                      title: CustomText(
                        title: 'No',
                        color: Colors.black,
                        size: MyTheme.normalTextSize(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RoundedButton(
                      title: 'Previous step',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Step8(widget.user)));
                      },
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Expanded(
                    child: RoundedButton(
                      onPressed: () {
                        widget.user.q6 = symptomsTime;
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Step10(widget.user)));
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
}
