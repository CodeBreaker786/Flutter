import 'package:avalinks/models/user/ForgotPasswordModel.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regexed_validator/regexed_validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        alignment: Alignment.center,
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/icon_forgot_pass.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Reset your password',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'New password will sent to the Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Email Id",style: TextStyle(color: Colors.white),),
                      TextFormField(
                        controller: emailController,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Email Id',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Email Id';
                          } else if (!validator.email(value)) {
                            return 'Invalid Email Id';
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
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          forgotPassword(emailController.text);
                        }
                      }),
                )
              ],
            )),
      ),
    );
  }

  forgotPassword(String email) async {
    var data = {'email': email, 'user_role_id': AppConstant.USER_ROLE_ID};
    HttpResponse httpResponse =
        await MyHttpClient(context).get(UrlUtils.FORGOT_PASSWORD, data);
    if (httpResponse.success) {
      ForgotPasswordModel model =
          ForgotPasswordModel.fromJsonMap(httpResponse.response);
      if (model.status == 1) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Forgot Password'),
                  content: Text(model.message),
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
      } else {
        Utils().showMessageDialog(context, "Error", model.message);
      }
    } else {
      Utils().showMessageDialog(context, "Error", httpResponse.error);
    }
  }
}
