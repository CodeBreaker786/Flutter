import 'dart:io';

import 'package:avalinks/list_items/ServiceItemView.dart';
import 'package:avalinks/list_items/user/VendorItemView.dart';
import 'package:avalinks/models/country/CountryData.dart';
import 'package:avalinks/models/service/ServiceData.dart';
import 'package:avalinks/models/service/ServicesListModel.dart';
import 'package:avalinks/models/vendor/VendorData.dart';
import 'package:avalinks/models/vendor/VendorListModel.dart';
import 'package:avalinks/screen/NoDataScreen.dart';
import 'package:avalinks/screen/user/ServiceDetailsScreen.dart';
import 'package:avalinks/screen/user/ServiceListScreen.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  String searchKey, type;

  SearchResultScreen(this.searchKey, this.type);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchResultState();
  }
}

class SearchResultState extends State<SearchResultScreen> {
  String userId;
  int pageNo = 1;

  List<ServiceData> serviceDataList = new List();
  List<VendorData> vendorDataList = new List();

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
      search();
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
        title: Text(widget.type == 'vendor' ? 'Vendors' : 'Services'),
        centerTitle: true,
      ),
      body: nodata
          ? NoDataScreen()
          : ListView.builder(
              padding: EdgeInsets.only(bottom: AppConstant.LIST_BOTTOM_PADDING),
              controller: scrollController,
              itemCount: widget.type == 'vendor'
                  ? vendorDataList.length
                  : serviceDataList.length,
              itemBuilder: (context, index) {
                return widget.type == 'vendor'
                    ? vendorItemBuilder(context, index)
                    : serviceItemBuilder(context, index);
              },
            ),
    );
  }

  _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter < 100 && hasNext && !isLoading) {
      pageNo++;
      search();
    }
  }

  Widget vendorItemBuilder(context, index) {
    VendorData data = vendorDataList[index];
    return GestureDetector(
      child: VendorItemView(data),
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServiceListScreen(data.user_id)));
      },
    );
  }

  Widget serviceItemBuilder(context, index) {
    ServiceData data = serviceDataList[index];
    return GestureDetector(
      child: ServiceItemView(data),
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ServiceDetailsScreen(serviceDataList[index])));
      },
    );
  }

  search() async {
    isLoading = true;
    CountryData countryData = await Utils().getCountry();
    var data = {
      'keyword': widget.searchKey,
      'country_id': countryData?.country_id,
      'type': widget.type,
      'page': pageNo
    };
    print(data);
    HttpResponse httpResponse = await MyHttpClient(context)
        .get(UrlUtils.SEARCH, data, showProgress: pageNo == 1 ? true : false);
    if (httpResponse.success) {
      if (widget.type == 'vendor') {
        VendorListModel vendorListModel =
            VendorListModel.fromJsonMap(httpResponse.response);
        if (vendorListModel != null &&
            vendorListModel.status == 1 &&
            vendorListModel.data != null &&
            vendorListModel.data.length > 0) {
          if (vendorDataList != null &&
              vendorDataList.length > 0 &&
              vendorDataList[vendorDataList.length - 1] == null) {
            vendorDataList.removeLast();
          }
          hasNext = vendorListModel.is_last == 1 ? false : true;
          vendorDataList.addAll(vendorListModel.data);
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
      } else if (widget.type == 'service') {
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
      }
    } else {
      Utils().showMessageDialog(context, 'Search', httpResponse.error);
    }
    isLoading = false;
  }
}
