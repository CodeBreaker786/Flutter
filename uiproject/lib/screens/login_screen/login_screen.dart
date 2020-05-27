import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uiproject/colors.dart';
import 'package:uiproject/screens/wallet_screen/wallet_widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Container(
                      width: 38,
                      child: Image.asset(
                        'icons/arrow.png',
                        fit: BoxFit.cover,
                      ))),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                      child: Text("Welcome Login",
                          style: googleTextStyle(
                            UiColors.hardblue,
                            40,
                          )))),
              SizedBox(
                height: 35,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton.icon(
                      hoverColor: UiColors.hardblue,
                      borderSide: BorderSide(color: Colors.grey),
                      color: Colors.grey,
                      splashColor: UiColors.hardblue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Icon(FontAwesomeIcons.facebookF,
                            color: UiColors.darkblue),
                      ),
                      onPressed: () async {},
                      label: Container(),
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Expanded(
                    child: OutlineButton.icon(
                      splashColor: UiColors.hardblue,
                      borderSide: BorderSide(color: Colors.grey),
                      color: Colors.grey,
                      hoverColor: UiColors.hardblue,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Icon(FontAwesomeIcons.google,
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () async {},
                      label: Container(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                style: TextStyle(
                  fontSize: 20,
                  color: UiColors.hardblue,
                ),
                decoration: InputDecoration(
                    suffix: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    labelText: 'Username',
                    labelStyle: googleTextStyle(
                      Colors.grey,
                      20,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                style: googleTextStyle(UiColors.hardblue, 20),
                decoration: InputDecoration(
                    suffix: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    labelText: 'Password',
                    labelStyle: googleTextStyle(
                      Colors.grey,
                      20,
                    ),
                    border: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.red)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 3),
                      child: Icon(FontAwesomeIcons.circle)),
                  Text("Remember me"),
                  Expanded(child: Container()),
                  GestureDetector(
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onTap: () {},
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 3),
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  fillColor: UiColors.darkblue,
                  child: Text(
                    "Login",
                    style: googleTextStyle(
                      Colors.white,
                      20,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have a account?",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Sign up",
                    style: TextStyle(color: UiColors.hardblue, fontSize: 20),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
