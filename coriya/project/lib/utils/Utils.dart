import 'dart:convert';
import 'dart:io';

import 'package:avalinks/models/country/CountryData.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Utils {
  showMessageDialog(BuildContext context, String title, String message,
      {bool cancelable = true}) {
    showDialog(
        context: context,
        barrierDismissible: cancelable,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  showImageWithImageLoader(String path, {double height, double width}) {
    File f = null;
    if (path != null) {
      File(path);
    }
    if (f != null && f.existsSync()) {
      return Image.file(
        f,
        height: height,
        width: width,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: path,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        height: height,
        width: width,
      );
    }
  }

  Future<bool> setCountry(CountryData countryData) async {
    String str = json.encode(countryData.toJson());
    bool success =
        await PrefsUtils.setStringPreference(AppConstant.COUNTRY, str);
    return success;
  }

  Future<CountryData> getCountry() async {
    String str = await PrefsUtils.getStringPreference(AppConstant.COUNTRY);
    if (str != null && str.isNotEmpty) {
      dynamic data = json.decode(str);
      CountryData countryData = CountryData.fromJsonMap(data);
      return countryData;
    }
    return null;
  }
}
