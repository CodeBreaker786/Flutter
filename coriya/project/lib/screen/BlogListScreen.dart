import 'dart:io';

import 'package:avalinks/models/blogs/BlogData.dart';
import 'package:avalinks/models/blogs/BlogListModel.dart';
import 'package:avalinks/screen/NoDataScreen.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BlogListState();
  }
}

class BlogListState extends State<BlogListScreen> {
  String userId;
  String userRoleId;
  int pageNo = 1;

  List<BlogData> blogDataList = new List();

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
    initData();
    scrollController.addListener(_scrollListener);
    super.initState();
    new Future.delayed(Duration.zero, () {
      getBlogList();
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
      appBar:
          (userRoleId != null && userRoleId == AppConstant.VENDOR_ROLE_ID_VAL)
              ? AppBar(
                  title: Text('Blogs'),
                )
              : null,
      body: nodata
          ? NoDataScreen()
          : ListView.builder(
              padding: EdgeInsets.only(bottom: AppConstant.LIST_BOTTOM_PADDING),
              controller: scrollController,
              itemCount: blogDataList.length,
              itemBuilder: (context, index) {
                return blogItemBuilder(context, index);
              },
            ),
    );
  }

  _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter < 100 && hasNext && !isLoading) {
      pageNo++;
      getBlogList();
    }
  }

  Widget blogItemBuilder(context, index) {
    BlogData data = blogDataList[index];
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: data == null
            ? new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text("Loading"),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.blog_title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Html(
                    data: HtmlUnescape().convert(data.blog_body),
                    onLinkTap: (url) async {
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }

  initData() async {
    userId = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
    userRoleId = await PrefsUtils.getStringPreference(AppConstant.USER_ROLE_ID);
    setState(() {});
  }

  getBlogList() async {
    isLoading = true;
    var data = {'user_id': userId, 'page': pageNo};
    HttpResponse httpResponse = await MyHttpClient(context).get(
        UrlUtils.BLOG_LIST, data,
        showProgress: pageNo == 1 ? true : false);
    if (httpResponse.success) {
      BlogListModel blogListModel =
          BlogListModel.fromJsonMap(httpResponse.response);
      if (blogListModel != null &&
          blogListModel.status == 1 &&
          blogListModel.data != null &&
          blogListModel.data.length > 0) {
        print('has next ${blogListModel.is_last}');
        if (blogDataList != null &&
            blogDataList.length > 0 &&
            blogDataList[blogDataList.length - 1] == null) {
          blogDataList.removeLast();
        }
        hasNext = blogListModel.is_last == 1 ? false : true;
        blogDataList.addAll(blogListModel.data);
        if (hasNext) {
          blogDataList.add(null);
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
      Utils().showMessageDialog(context, 'Blogs', httpResponse.error);
    }
    isLoading = false;
  }
}
