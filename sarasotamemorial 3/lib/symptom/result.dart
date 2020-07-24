import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sarasotamemorial/model/user.dart';
import 'package:sarasotamemorial/networking.dart';
import 'package:sarasotamemorial/theme.dart';
import 'package:sarasotamemorial/widgets/customtext.dart';
import 'package:sarasotamemorial/widgets/sliderthumb.dart';

class Result extends StatefulWidget {
  final User user;

  Result(this.user);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool isLoading = true;
  int symptomsTime = 1;
  ui.Image customImage;
  String triageScore = "";

  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  void initState() {
    super.initState();
    load('assets/images/thumb.png').then((image) {
      setState(() {
        customImage = image;
      });
    });
    getData();
  }

  getData() async {
    triageScore = await NetworkHelper.getTriageScore(widget.user);
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
            Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 30),
              child: CustomText(
                title:
                    'This is just a suggestion of where you should go now and should not be relied on over and above your own instinct and judgement',
                color: Colors.black,
                size: MyTheme.normalTextSize(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white,
                  trackHeight: 1.0,
                  thumbColor: Colors.black,
                  thumbShape: SliderThumbImage(customImage),
                  overlayShape: SliderThumbImage(customImage),
                ),
                child: Slider(
                    value: triageScore != "" ? int.parse(triageScore) / 100 : 0,
                    onChanged: (value) {
                      setState(() {});
                    }),
              ),
            ),
            Container(
              height: 70,
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/bar.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomText(title: 'Walk-in Clinic'),
                CustomText(title: 'Family Doctor'),
                CustomText(title: 'Emergency')
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: CustomText(
                title:
                    'Symptom checker is designed to help you decide where to seek professional medical advice. Symptom checker uses the results from the Symptoms you have just entered and then combines them with your answers to the seven questions to give a total score which is displayed on the bar above',
                color: Colors.grey,
                size: MyTheme.normalTextSize(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
