import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sarasotamemorial/model/user.dart';
import 'package:sarasotamemorial/symptom/step1.dart';
import 'package:sarasotamemorial/symptom/step3.dart';
import 'package:sarasotamemorial/theme.dart';
import 'package:sarasotamemorial/widgets/customtext.dart';
import 'package:sarasotamemorial/widgets/linkbutton.dart';
import 'package:sarasotamemorial/widgets/roundedbutton.dart';

class Step2 extends StatefulWidget {
  final User user;

  Step2(this.user);

  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  bool isLoading = true;
  TextEditingController symptomTEC = new TextEditingController();
  List symptomList = new List();

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
                        title: 'What are your symptoms?',
                        size: MyTheme.largeText(),
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      height: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: symptomTEC,
                              decoration: InputDecoration(
                                hintText: 'Enter a Symptom',
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: MyTheme.normalTextSize(),
                                    fontFamily: 'Lexend'),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                ),
                              ),
                            ),
                          ),
                          LinkButton(
                            onPressed: () {
                              if (symptomTEC.text != "") {
                                symptomList.add(symptomTEC.text.trim());
                                symptomTEC.clear();
                                setState(() {});
                              } else
                                MyTheme.toast('Enter a symptom');
                            },
                            title: 'ADD',
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(50, 20, 50, 10),
                        child: Wrap(
                          children: buildSymptomsList(),
                        )),
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
                                    new Step1()));
                      },
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Expanded(
                    child: RoundedButton(
                      onPressed: () {
                        if (symptomList.length == 0)
                          MyTheme.toast('Add at least one symptom');
                        else {
                          widget.user.symptoms = symptomList.join(", ");
                          Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Step3(widget.user)));
                        }
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

  buildSymptomsList() {
    List<Widget> choices = List();
    symptomList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          selected: false,
          label: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              CustomText(
                title: item,
                size: MyTheme.tinyTextSize(),
                color: Colors.blue,
                alignment: TextAlign.center,
              ),
              Container(width: 5),
              Icon(
                Icons.clear,
                color: Colors.red,
                size: MyTheme.tinyTextSize(),
              ),
            ],
          ),
          onSelected: (selected) {
            setState(() {
              symptomList.remove(item);
            });
          },
        ),
      ));
    });
    return choices;
  }
}
