import 'dart:io';

import 'package:avalinks/models/country/CountryData.dart';
import 'package:avalinks/screen/user/SearchResultScreen.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<UserHomeScreen> {
  String searchType = 'Vendor';
  TextEditingController searchController = new TextEditingController();

  BannerAd _bannerAd;

  static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
    testDevices: <String>[AppConstant.AD_TEST_DEVICE],
  );

  BannerAd createBannerAd() {
    return new BannerAd(
      adUnitId: Platform.isAndroid
          ? AppConstant.BANNER_ANDROID
          : AppConstant.BANNER_IOS,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      getCountry();
      FirebaseAdMob.instance.initialize(
          appId: Platform.isAndroid
              ? AppConstant.APP_ID_ANDROID
              : AppConstant.APP_ID_IOS);
      _bannerAd = createBannerAd()
        ..load()
        ..show();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          child: Image.asset(
            'images/icon_app_logo.png',
            height: 100,
          ),
        ),
        Card(
          margin: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15),
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Search vendors & Services with their name, location, service etc...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              RadioButtonGroup(
                margin: EdgeInsets.only(top: 20),
                orientation: GroupedButtonsOrientation.HORIZONTAL,
                labels: <String>['Vendor', 'Service'],
                picked: searchType,
                onSelected: (selected) {
                  setState(() {
                    searchType = selected;
                  });
                },
                itemBuilder: (Radio rb, Text txt, int i) {
                  return Row(
                    children: <Widget>[
                      rb,
                      Text(
                        txt.data,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                      )
                    ],
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: searchType == 'Vendor'
                        ? 'Enter keyword for search Vendor'
                        : 'Enter keyword for search Service',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Theme.of(context).primaryColor,)
                    ),
                      child: Text(
                        'Search',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        search(searchController.text, searchType.toLowerCase());
                      }),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Future getCountry() async {
    CountryData countryData = await Utils().getCountry();
    if (countryData == null) {
      dynamic cData = await Navigator.of(context).pushNamed('/get_country');
      if (cData != null && cData is CountryData) {
        countryData = cData;
        await Utils().setCountry(countryData);
      }
    }
  }

  search(String searchKey, String type) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchResultScreen(searchKey, type)));
  }
}
