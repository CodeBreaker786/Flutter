import 'package:flutter/material.dart';
import 'package:sarasotamemorial/theme.dart';
import 'package:sarasotamemorial/widgets/customtext.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  TextEditingController mobileTextEditingController;

  @override
  Widget build(BuildContext context) {
    MyTheme.init(context);

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          size: MyTheme.normalTextSize(),
          title: 'Privacy',
        ),
      ),
      body: Container(),
    );
  }
}
