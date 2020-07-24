import 'package:flutter/material.dart';
import 'package:sarasotamemorial/theme.dart';
import 'package:sarasotamemorial/widgets/customtext.dart';
import 'package:store_redirect/store_redirect.dart';

class Apps extends StatefulWidget {
  @override
  _AppsState createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  TextEditingController mobileTextEditingController;

  @override
  Widget build(BuildContext context) {
    MyTheme.init(context);

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          size: MyTheme.normalTextSize(),
          title: 'Apps',
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              'assets/images/smh_icon.jpg',
            ),
            title: CustomText(
              title: 'Sarasota Memorial',
            ),
            subtitle: CustomText(
              title: 'Download',
              color: Colors.blue,
            ),
            onTap: () {
              StoreRedirect.redirect(
                  androidAppId:
                      "com.soln.SE35BCA74A3BE95A854E67E90FEB1DBB3&hl=en_US",
                  iOSAppId: "397478168");
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/wayfinder.png',
            ),
            title: CustomText(
              title: 'SMH Wayfinder',
            ),
            subtitle: CustomText(
              title: 'Download',
              color: Colors.blue,
            ),
            onTap: () {
              StoreRedirect.redirect(
                  androidAppId:
                      "com.soln.SE35BCA74A3BE95A854E67E90FEB1DBB3&hl=en_US",
                  iOSAppId: "397478168");
            },
          ),
        ],
      ),
    );
  }
}
