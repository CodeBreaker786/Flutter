import 'dart:io' show Platform;

import 'package:avalinks/models/user/ChangePasswordModel.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChangePasswordState();
  }
}

class ChangePasswordState extends State<ChangePasswordScreen> {
  String userId;
  String userRoleId;
  final _formKey = GlobalKey<FormState>();

  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

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
      appBar:
          (userRoleId != null && userRoleId == AppConstant.VENDOR_ROLE_ID_VAL)
              ? AppBar(
                  title: Text('Change Password'),
                )
              : null,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Old Password"),
                  TextFormField(
                    controller: oldPasswordController,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 5.0
                      )
                    ),hintText: 'Enter Old Password'),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Old Password';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("New Password"),
                  TextFormField(
                    controller: newPasswordController,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(hintText: 'Enter New Password',border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 5.0
                        )
                    )),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter New Password';
                      } else if (value.length < 6) {
                        return 'New Password field must be at least 6 characters in length.';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Confirm Password"),
                  TextFormField(
                    controller: confirmPasswordController,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(hintText: 'Enter Confirm Password',border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5.0)
                    )),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Confirm Password';
                      } else if (value != newPasswordController.text) {
                        return 'Confirm password should be same as New Password';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(18.0)
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Change Password',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    changePassword(
                        oldPasswordController.text, newPasswordController.text);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  changePassword(String oldPassword, String newPassword) async {
    var data = {
      'user_id': userId,
      'old_password': oldPassword,
      'new_password': newPassword,
      'user_role_id': userRoleId
    };

    HttpResponse httpResponse = await MyHttpClient(context).post(UrlUtils.CHANGE_PASSWORD, data);
    if (httpResponse.success)
    {
      ChangePasswordModel model = ChangePasswordModel.fromJsonMap(httpResponse.response);
      if (model.status == 1)
      {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Change Password'),
                  content: Text(model.message),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ));
      } else {
        Utils().showMessageDialog(context, "Error", model.message);
      }
    } else {
      Utils().showMessageDialog(context, "Error", httpResponse.error);
    }
  }

  initData() async {
    userId = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
    userRoleId = await PrefsUtils.getStringPreference(AppConstant.USER_ROLE_ID);
    setState(() {});
  }
}
