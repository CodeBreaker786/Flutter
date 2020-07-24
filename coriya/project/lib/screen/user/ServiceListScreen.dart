import 'dart:io';

import 'package:avalinks/list_items/ServiceItemView.dart';
import 'package:avalinks/models/service/ServiceData.dart';
import 'package:avalinks/models/service/ServicesListModel.dart';
import 'package:avalinks/screen/NoDataScreen.dart';
import 'package:avalinks/screen/user/ServiceDetailsScreen.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceListScreen extends StatefulWidget {
  String vendorId;

  ServiceListScreen(this.vendorId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ServiceListState();
  }
}

class ServiceListState extends State<ServiceListScreen> {
  int pageNo = 1;

  List<ServiceData> serviceDataList = new List();

  ScrollController scrollController = new ScrollController();
  bool hasNext = false;
  bool isLoading = false;

  bool nodata = false;

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
    scrollController.addListener(_scrollListener);
    super.initState();
    new Future.delayed(Duration.zero, () {
      getServiceList();
    });
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
        title: Text('Services'),
      ),
      body: nodata
          ? NoDataScreen()
          : ListView.builder(
              padding: EdgeInsets.only(bottom: AppConstant.LIST_BOTTOM_PADDING),
              controller: scrollController,
              itemCount: serviceDataList.length,
              itemBuilder: (context, index) {
                return serviceItemBuilder(context, index);
              },
            ),
    );
  }

  _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter < 100 && hasNext && !isLoading) {
      pageNo++;
      getServiceList();
    }
  }

  Widget serviceItemBuilder(context, index) {
    ServiceData data = serviceDataList[index];
    return GestureDetector(
      child: ServiceItemView(data),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ServiceDetailsScreen(serviceDataList[index])));
      },
    );
  }

  getServiceList() async {
    isLoading = true;
    var data = {'user_id': widget.vendorId, 'page': pageNo};
    HttpResponse httpResponse = await MyHttpClient(context).get(
        UrlUtils.SERVICE_LIST, data,
        showProgress: pageNo == 1 ? true : false);
    if (httpResponse.success) {
      ServicesListModel servicesListModel =
          ServicesListModel.fromJsonMap(httpResponse.response);
      if (servicesListModel != null &&
          servicesListModel.status == 1 &&
          servicesListModel.data != null &&
          servicesListModel.data.length > 0) {
        if (serviceDataList != null &&
            serviceDataList.length > 0 &&
            serviceDataList[serviceDataList.length - 1] == null) {
          serviceDataList.removeLast();
        }
        hasNext = servicesListModel.is_last == 1 ? false : true;
        serviceDataList.addAll(servicesListModel.data);
        if (hasNext) {
          serviceDataList.add(null);
        }
        setState(() {
          nodata = false;
        });
      } else {
        setState(() {
          nodata = true;
        });
      }
    } else {
      Utils().showMessageDialog(context, 'Service', httpResponse.error);
    }
    isLoading = false;
  }
}
