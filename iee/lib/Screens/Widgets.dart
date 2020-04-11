import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

List<CircularStackEntry> circularData = <CircularStackEntry>[
  new CircularStackEntry(
    <CircularSegmentEntry>[
      new CircularSegmentEntry(10.0, Color(0xff40b24b), rankKey: 'Q4'),
      new CircularSegmentEntry(18.0, Color(0xffec3337), rankKey: 'Q3')
    ],
    rankKey: 'Quarterly Profits',
  ),
];
final index = 0;

Material mychart1Items(Widget mywidget) {
  return Material(
    color: Colors.white,
    elevation: 14.0,
    borderRadius: BorderRadius.circular(24.0),
    shadowColor: Color(0x802196F3),
    child: InkWell(
      onTap: () {},
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(1.0), child: mywidget),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Material Text_Card(String title, Function function, TextStyle style) {
  return Material(
    color: Colors.white,
    elevation: 14.0,
    borderRadius: BorderRadius.circular(24.0),
    shadowColor: Color(0x802196F3),
    child: InkWell(
        hoverColor: Color(0x802196F3),
        splashColor: Color(0x802196F3),
        onTap: () {
          function();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
              child: Text(title, textAlign: TextAlign.center, style: style)),
        )),
  );
}

Material myCircularItems(int total, int index) {
  return Material(
    color: Colors.white,
    elevation: 14.0,
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
    shadowColor: Color(0x802196F3),
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 10.0,
                  backgroundColor: Colors.red,
                  animation: true,
                  animateFromLastPercent: true,
                  percent: (index + 1) / total,
                  center: new Text(
                      ("${(((index + 1) / total) * 100).toStringAsFixed(2)}%")),
                  animationDuration: 100,
                  progressColor: Colors.green,
                )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 12,
                    width: 12,
                    color: Color(0xff40b24b),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Attempted",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 12,
                    width: 12,
                    color: Color(0xffec3337),
                  ),
                ),
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

TextStyle style() {
  return TextStyle(
      fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20);
}

const Ans_Quest = [
  {
    "Question": 'Who is the funniest Guy of class',
    'Option': ['Huzaifa', 'Mahsum', 'adil']
  },
  {
    "Question": 'Who is the Angry Guy of class',
    'Option': ['irfan', 'Talha', 'Hussain', 'malik', 'fani']
  },
  {
    "Question": 'Who is the funniest Guy of class',
    'Option': ['Huzaifa', 'Mahsum', 'adil']
  },
  {
    "Question": 'Who is the Angry Guy of class',
    'Option': ['irfan', 'Talha', 'Hussain', 'malik', 'fani']
  },
  {
    "Question": 'Who is the Angry Guy of class',
    'Option': ['irfan', 'Talha', 'Hussain', 'malik', 'fani']
  },
  {
    "Question": 'Who is the funniest Guy of class',
    'Option': ['Huzaifa', 'Mahsum', 'adil']
  },
  {
    "Question": 'Who is the funniest Guy of class',
    'Option': ['Huzaifa', 'Mahsum', 'adil']
  },
  {
    "Question": 'Who is the funniest Guy of class',
    'Option': ['Huzaifa', 'Mahsum', 'adil']
  },
  {
    "Question": 'Who is the funniest Guy of class',
    'Option': ['Huzaifa', 'Mahsum', 'adil']
  },
  {
    "Question": 'Who is the funniest Guy of class',
    'Option': ['Huzaifa', 'Mahsum', 'adil']
  },
];

TextFormField textfiled(PH, OnEnter, OnChanged) {
  return TextFormField(
    onChanged: (val) {},
    onFieldSubmitted: (val) {},
    decoration: new InputDecoration(
      labelText: "Enter Question",
      hintText: PH,
      hasFloatingPlaceholder: true,
      fillColor: Colors.white,
      hoverColor: Colors.amber,
      border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25.0),
        borderSide: new BorderSide(),
      ),
      //fillColor: Colors.green
    ),
    validator: (val) {
      if (val.length == 0) {
        return "Email cannot be empty";
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.emailAddress,
    style: new TextStyle(),
  );
}

SpinKitDoubleBounce LodingBar(context) {
  return SpinKitDoubleBounce(
    color: Theme.of(context).accentColor,
    size: 60,
  );
}
