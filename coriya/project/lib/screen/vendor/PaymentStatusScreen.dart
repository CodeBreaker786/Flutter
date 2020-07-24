import 'package:avalinks/models/subscription/PaymentCallbackData.dart';
import 'package:avalinks/models/subscription/PaymentCallbackModel.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:flutter/material.dart';

class PaymentStatusScreen extends StatefulWidget {
  String url;

  PaymentStatusScreen(this.url);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentStatusState();
  }
}

class PaymentStatusState extends State<PaymentStatusScreen> {
  bool showUI = false;
  bool status;
  PaymentCallbackData data = null;
  String error = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Future.delayed(Duration.zero, () {
      getPaymentDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: showUI
            ? Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      'images/icon_app_logo.png',
                      height: 80,
                      width: 150,
                    ),
                    status
                        ? Icon(
                            Icons.check_circle,
                            size: 100.0,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.error,
                            size: 100.0,
                            color: Colors.red,
                          ),
                    Text(
                      status
                          ? 'Payment Successful!\nTranaction Id : ${data.transaction_id}'
                          : error,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    ButtonTheme(
                      minWidth: double.maxFinite,
                      height: 50.0,
                      child: RaisedButton(
                          child: Text(
                            'Go to Home',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          }),
                    )
                  ],
                ),
              )
            : Padding(padding: EdgeInsets.all(0.0)),
      ),
    );
  }

  getPaymentDetails() async {
    HttpResponse httpResponse =
        await MyHttpClient(context).get(widget.url, null);
    if (httpResponse.success) {
      PaymentCallbackModel paymentCallbackModel =
          PaymentCallbackModel.fromJsonMap(httpResponse.response);
      if (paymentCallbackModel != null) {
        if (paymentCallbackModel.status == 1) {
          setState(() {
            showUI = true;
            status = true;
            data = paymentCallbackModel.data;
            error = '';
          });
        } else {
          setState(() {
            showUI = true;
            status = false;
            data = null;
            error = paymentCallbackModel.message;
          });
        }
      } else {
        setState(() {
          showUI = true;
          status = false;
          data = null;
          error = 'Something may went wrong! Please try again!';
        });
      }
    } else {
      setState(() {
        showUI = true;
        status = false;
        data = null;
        error = httpResponse.error;
      });
    }
  }
}
