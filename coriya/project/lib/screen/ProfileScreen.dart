import 'dart:io';

import 'package:avalinks/models/user/UserData.dart';
import 'package:avalinks/models/user/UserModel.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as Path;
import 'package:regexed_validator/regexed_validator.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ProfileState();
  }
}

class ProfileState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String userId;
  String userRoleId;

  TextEditingController fNameController = new TextEditingController();
  TextEditingController lNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNoController = new TextEditingController();

  String avatarPath = null;

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
    initData();
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
        title: Text('Profile'),
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 10.0,
                bottom: AppConstant.LIST_BOTTOM_PADDING),
            children: <Widget>[
              GestureDetector(
                child: CircleAvatar(
                  radius: 60.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Utils().showImageWithImageLoader(avatarPath)),
                  backgroundColor: avatarPath == null
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                ),
                onTap: () async {
                  String filePath =
                      await FilePicker.getFilePath(type: FileType.image);
                  if (filePath != null) {
                    setState(() {
                      avatarPath = filePath;
                    });
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('First Name'),
                    TextFormField(
                      controller: lNameController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          hintText: 'Enter First Name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 5.0))),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter First Name';
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Last Name'),
                    TextFormField(
                      controller: lNameController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          hintText: 'Enter Last Name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 5.0))),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Last Name';
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Email Id"),
                    TextFormField(
                      enabled: false,
                      controller: emailController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 5.0)),
                          hintText: 'Your Email Id'),
                      keyboardType: TextInputType.emailAddress,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Phone No"),
                    TextFormField(
                      controller: phoneNoController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 5.0)),
                          hintText: 'Phone No'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Phone No';
                        } else if (!validator.phone(value)) {
                          return 'Invalid Phone No';
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Color(0xff72ADFF))),
                    color: Color(0xff72ADFF),
                    child: Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        updateProfile(avatarPath, fNameController.text,
                            lNameController.text, phoneNoController.text);
                      }
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }

  initData() async {
    userId = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
    userRoleId = await PrefsUtils.getStringPreference(AppConstant.USER_ROLE_ID);
    fNameController.text =
        await PrefsUtils.getStringPreference(AppConstant.F_NAME);
    lNameController.text =
        await PrefsUtils.getStringPreference(AppConstant.L_NAME);
    emailController.text =
        await PrefsUtils.getStringPreference(AppConstant.USER_EMAIL);
    phoneNoController.text =
        await PrefsUtils.getStringPreference(AppConstant.USER_PHONE);
    avatarPath =
        await PrefsUtils.getStringPreference(AppConstant.USER_PROFILE_PIC);
    setState(() {});
  }

  updateProfile(
      String profileImagePath, String fName, String lName, String phone) async {
    FormData formData;
    File profileImage =
        profileImagePath == null ? null : File(profileImagePath);
    if (profileImage != null && profileImage.existsSync()) {
      formData = new FormData.from({
        'user_id': userId,
        'profile_pic':
            new UploadFileInfo(profileImage, Path.basename(profileImage.path)),
        'first_name': fName,
        'last_name': lName,
        'user_phone': phone,
        'user_role_id': userRoleId
      });
    } else {
      formData = new FormData.from({
        'user_id': userId,
        'first_name': fName,
        'last_name': lName,
        'user_phone': phone,
        'user_role_id': userRoleId
      });
    }
    HttpResponse httpResponse = await MyHttpClient(context)
        .postFormData(UrlUtils.EDIT_PROFILE, formData);
    print(httpResponse);
    if (httpResponse.success) {
      UserModel model = UserModel.fromJsonMap(httpResponse.response);
      if (model.status == 1) {
        storeUserDataAndGotoNext(model.data);
      } else {
        Utils().showMessageDialog(context, "Error", model.message);
      }
    } else {
      Utils().showMessageDialog(context, "Error", httpResponse.error);
    }
  }

  storeUserDataAndGotoNext(UserData data) {
    PrefsUtils.setStringPreference(AppConstant.USER_ID, data.user_id);
    PrefsUtils.setStringPreference(AppConstant.F_NAME, data.first_name);
    PrefsUtils.setStringPreference(AppConstant.L_NAME, data.last_name);
    PrefsUtils.setStringPreference(AppConstant.USER_EMAIL, data.user_email);
    PrefsUtils.setStringPreference(AppConstant.USER_PHONE, data.user_phone);
    PrefsUtils.setStringPreference(
        AppConstant.USER_PROFILE_PIC, data.user_profile_pic);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text('Profile'),
              content: Text('Profile updated successfully!'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  },
                )
              ],
            ));
  }
}
