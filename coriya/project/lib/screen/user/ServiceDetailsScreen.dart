import 'dart:io';

import 'package:avalinks/models/service/ServiceData.dart';
import 'package:avalinks/models/service/ServiceMedia.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ServiceDetailsScreen extends StatefulWidget {
  ServiceData data;

  ServiceDetailsScreen(this.data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ServiceDetailsState();
  }
}

class ServiceDetailsState extends State<ServiceDetailsScreen> {
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
    FirebaseAdMob.instance.initialize(
        appId: Platform.isAndroid
            ? AppConstant.APP_ID_ANDROID
            : AppConstant.APP_ID_IOS);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.business_name),
      ),
      body: ListView(
        padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: AppConstant.LIST_BOTTOM_PADDING),
        children: <Widget>[
          showDataRawWidget(
              'Service Name : ',
              widget.data.selected_category == null
                  ? ''
                  : widget.data.selected_category.serviceCategoryName),
          showDataRawWidget('Price : ', widget.data.service_price),
          showDataRawWidget('Description : ', widget.data.service_description),
          showDataRawWidget('Address : ', widget.data.service_address),
          showDataRawWidget(
              'Working Hour : ', widget.data.service_working_hour),
          showDataRawWidget('Email : ', widget.data.service_email),
          showDataRawWidget('Phone : ', widget.data.service_phone),
          showDataRawWidget('Website : ', widget.data.service_website),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Text(
                  'Media',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                (widget.data.media == null || widget.data.media.length == 0)
                    ? Text('No Media')
                    : GridView.count(
                        crossAxisCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: widget.data.media.map((ServiceMedia media) {
                          return GridTile(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.black)),
                              child: Utils()
                                  .showImageWithImageLoader(media.media_path),
                            ),
                          );
                        }).toList(),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showDataRawWidget(String key, String value) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            key,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            value == null ? '' : value,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
