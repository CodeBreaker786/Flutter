import 'package:flutter/material.dart';
import 'package:sarasotamemorial/pages/apps.dart';
import 'package:sarasotamemorial/pages/urgentcare.dart';
import 'package:sarasotamemorial/pages/webview.dart';
import 'package:sarasotamemorial/symptom/step1.dart';
import 'package:sarasotamemorial/theme.dart';
import 'package:sarasotamemorial/widgets/customtext.dart';
import 'package:location_permissions/location_permissions.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController mobileTextEditingController;

  @override
  Widget build(BuildContext context) {
    MyTheme.init(context);

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          size: MyTheme.normalTextSize(),
          title: "SMH Urgent Care",
        ),
      ),
      drawer: new Drawer(
          child: new ListView(
        cacheExtent: 10,
        addAutomaticKeepAlives: true,
        children: <Widget>[
          Container(
            color: Color(0xff639EC7),
            child: ListTile(
              title: new CustomText(
                  size: MyTheme.largeText(), title: 'SMH', color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.adjust,
            ),
            title: new CustomText(
                size: MyTheme.normalTextSize(), title: 'Urgent Care vs ER'),
            onTap: () {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new WebView(
                     title: "Urgent Care vs ER",
                     url: "https://www.smhurgentcare.com/urgent-care-vs-er/"),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.adjust),
            title: new CustomText(
                size: MyTheme.normalTextSize(), title: 'Our Apps'),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Apps()));
            },
          ),
          ListTile(
            leading: Icon(Icons.adjust),
            title: new CustomText(
                size: MyTheme.normalTextSize(), title: 'Privacy'),
            onTap: () {
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new WebView(title:"Privacy", url:"https://www.smh.com/privacy"),
                ),
              );
            },
          ),
        ],
      )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new WebView(
                       title: "Save My Spot",
                       url: "https://www.smhurgentcare.com/savemyspot/"),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image(
                    image: new AssetImage("assets/images/calendar.png"),
                    width: 80,
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CustomText(
                      title: 'Save my spot',
                      size: MyTheme.normalTextSize(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new Step1(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image(
                    image: new AssetImage("assets/images/symptom_icon.png"),
                    width: 80,
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CustomText(
                      title: 'Symptom Checker',
                      size: MyTheme.normalTextSize(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) =>   UrgentCare(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image(
                    image: new AssetImage("assets/images/pinicon.png"),
                    width: 80,
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CustomText(
                      title: 'Urgent Care Centers',
                      size: MyTheme.normalTextSize(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Image.asset('assets/images/urgentcare.jpeg'),
          ),
        ],
      ),
    );
  }
}
