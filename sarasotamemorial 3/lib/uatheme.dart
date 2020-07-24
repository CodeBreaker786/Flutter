import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sarasotamemorial/widgets/appsettings.dart';
 

class UATheme {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  static setTheme() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.grey.shade700,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
    );

    return ThemeData(
      primaryColor: AppSettings.primaryColor,
      accentColor: AppSettings.primaryColor,
      buttonColor: AppSettings.primaryColor,
      buttonTheme: ButtonThemeData(
        buttonColor: AppSettings.primaryColor,
        textTheme: ButtonTextTheme.accent,
        colorScheme: ColorScheme.light(),
      ),
      appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        color: AppSettings.primaryColor,
        brightness: Brightness.dark,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.grey,
      ),
      scaffoldBackgroundColor: AppSettings.appBackground,
      backgroundColor: AppSettings.appBackground,
      primarySwatch: Colors.blue,
    );
  }

  static largeSize() {
    return safeBlockHorizontal * 5;
  }

  static extraLargeSize() {
    return safeBlockHorizontal * 7;
  }

  static normalSize() {
    return safeBlockHorizontal * 4;
  }

  static headingSize() {
    return safeBlockHorizontal * 4.5;
  }

  static tinySize() {
    return safeBlockHorizontal * 3.5;
  }

  static extraTinySize() {
    return safeBlockHorizontal * 2.5;
  }

  static alert(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: normalSize());
  }

//flutter pub pub run flutter_launcher_icons:main
}
