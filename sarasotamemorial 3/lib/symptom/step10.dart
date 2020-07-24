import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sarasotamemorial/model/user.dart';
import 'package:sarasotamemorial/symptom/result.dart';
import 'package:sarasotamemorial/symptom/step9.dart';
import 'package:sarasotamemorial/theme.dart';
import 'package:sarasotamemorial/widgets/customtext.dart';
import 'package:sarasotamemorial/widgets/roundedbutton.dart';

class Step10 extends StatefulWidget {
  final User user;

  Step10(this.user);

  @override
  _Step10State createState() => _Step10State();
}

class _Step10State extends State<Step10> {
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
                            'Do you have any other serious, long term conditions?',
                        size: MyTheme.largeText(),
                      ),
                    ),
                    RadioListTile(
                      value: 1,
                      groupValue: symptomsTime,
                      onChanged: (newValue) =>
                          setState(() => symptomsTime = newValue),
                      title: CustomText(
                        title: 'No',
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
                                    new Step9(widget.user)));
                      },
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Expanded(
                    child: RoundedButton(
                      onPressed: () {
                        widget.user.q7 = symptomsTime;
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new Result(widget.user)));
                      },
                      title: 'Finish',
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
