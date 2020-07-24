import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyTheme {
  static String appName = 'SMH';

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

    return ThemeData(
      buttonColor: Color(0xff639EC7),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xff639EC7),
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme.dark(),
      ),
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        color: Color(0xff639EC7),
        brightness: Brightness.dark,
        elevation: 0,
      ),
      primarySwatch: Colors.blue,
    );
  }

  static headingSize() {
    return safeBlockHorizontal * 5;
  }

  static largeText() {
    return safeBlockHorizontal * 7;
  }

  static normalTextSize() {
    return safeBlockHorizontal * 4;
  }

  static tinyTextSize() {
    return safeBlockHorizontal * 3.5;
  }

  static extraTinyTextSize() {
    return safeBlockHorizontal * 2.5;
  }

  static roundedCorners(double radius) {
    return RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(radius));
  }

  static addBoxShadow(double radius) {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey,
          blurRadius: 1.0,
          offset: Offset(0, 1.0),
        ),
      ],
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

  static textField(String hint, TextEditingController textEditingController) {
    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      obscureText: false,
      controller: textEditingController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: MyTheme.normalTextSize(),
            fontFamily: 'Lexend'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static toast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.deepPurple.shade200,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
