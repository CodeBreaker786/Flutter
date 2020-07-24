import 'package:avalinks/models/subscription/MembershipPlanData.dart';
import 'package:avalinks/screen/vendor/PaymentStatusScreen.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  MembershipPlanData membershipPlanData;

  PaymentScreen(this.membershipPlanData);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentState();
  }
}

class PaymentState extends State<PaymentScreen> {
  String userId;
  WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: userId == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : WebView(
              initialUrl:
                  '${UrlUtils.PAYMENT}?amount=${widget.membershipPlanData.price_table_cost}&user_id=${userId}&price_table_id=${widget.membershipPlanData.price_table_id}',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                print('Webview : Created');
                this.controller = controller;
              },
              navigationDelegate: (request) {
                print('url : ${request.url}');
                if (request.url.contains(UrlUtils.PAYMENT_CALLBACK)) {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (context) => PaymentStatusScreen(request.url)));
                }
              },
              onPageFinished: (url) {
                print('finished : $url');
              },
            ),
    );
  }

  initData() async {
    String id = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
    setState(() {
      userId = id;
    });
  }

  showPaymentStatusDialog(bool success, String txnId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text(success ? 'Success' : 'Error'),
              content: Text(success
                  ? 'Payment is successful with Transaction Id : $txnId'
                  : 'Payment failed. Please try again.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }
}
