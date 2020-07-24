import 'dart:convert';

import 'package:avalinks/models/user/UserData.dart';
import 'package:avalinks/models/user/UserModel.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:regexed_validator/regexed_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String userRoleId = AppConstant.USER_ROLES[0].role_id;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool passObscure = true;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  final facebookLogin = FacebookLogin();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ListView(
                padding: EdgeInsets.all(15.0),
                shrinkWrap: true,
                children: <Widget>[
                  Image.asset(
                    'images/icon_app_logo.png',
                    height: 80,
                    width: 150,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Row(
                      children: AppConstant.USER_ROLES.map((val) {
                        return Row(
                          children: <Widget>[
                            Radio(
                                value: val.role_id,
                                groupValue: userRoleId,
                                onChanged: (newValue) {
                                  setState(() {
                                    print(newValue);
                                    userRoleId = newValue;
                                  });
                                }),
                            Text(
                              val.role,
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Email Id"),
                        TextFormField(
                          controller: emailController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(border: OutlineInputBorder(
                            borderSide: BorderSide(width: 5.0)
                          ),
                              hintText: 'Email Id', prefixIcon: Icon(Icons.email)),
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
                    margin: const EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Password"),
                        TextFormField(
                          controller: passwordController,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 5.0)
                            ),
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                icon: Icon(passObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    passObscure = !passObscure;
                                  });
                                }),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: passObscure,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/forgot_password');
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        shape:  RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff72ADFF))
                        ),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            login(
                                emailController.text, passwordController.text);
                          }
                        },
                      ),
                    ),
                  ),
                  userRoleId == AppConstant.USER_ROLE_ID_VAL
                      ? Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                    side: BorderSide(color: Colors.red)
                                  ),
                                  color: Colors.red,
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          'images/icon_google_plus.png',
                                          height: 35,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            'Login with google',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    _handleGoogleSignIn();
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                    side: BorderSide(color: Colors.blue)
                                  ),
                                  color: Colors.blue,
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          'images/icon_facebook.png',
                                          height: 35,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            'Login with facebook',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    _handleFacebookLogin();
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account yet?",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/register');
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login(String email, String pass) async {
    var data = {'email': email, 'password': pass, 'user_role_id': userRoleId};
    print(data);
    HttpResponse httpResponse =
        await MyHttpClient(context).post(UrlUtils.LOGIN, data);
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

  Future<void> _handleGoogleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        String googleId = googleSignInAccount.id;
        String name = googleSignInAccount.displayName;
        String email = googleSignInAccount.email;
        String photo = googleSignInAccount.photoUrl;
        await _googleSignIn.signOut();
        if (validator.email(email)) {
          socialLogin(googleId, '', name, '', email, photo);
        } else {
          email = await getUserEmailDialog();
          if (validator.email(email)) {
            socialLogin(googleId, '', name, '', email, photo);
          }
        }
      } else {
        print('User Not Logged In');
      }
    } catch (error) {
      print('Error : $error');
    }
  }

  Future<void> _handleFacebookLogin() async {
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        await facebookLogin.logOut();
        getUserDataFromFacebook(token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('FB Login : Cancel');
        break;
      case FacebookLoginStatus.error:
        print('FB Login : Error');
        break;
    }
  }

  getUserDataFromFacebook(String token) async {
    var data = {
      'fields': 'name,first_name,last_name,email',
      'access_token': token
    };
    HttpResponse httpResponse = await MyHttpClient(context)
        .get(UrlUtils.FACEBOOK_GRAPH_URL, data, useBaseUrl: false);
    if (httpResponse.success) {
      final data = json.decode(httpResponse.response);
      String fbId = data['id'];
      String fName = data['first_name'];
      String lName = data['last_name'];
      String email = data['email'] ?? '';
      String photo = 'https://graph.facebook.com/$fbId/picture?type=large';

      if (validator.email(email)) {
        socialLogin('', fbId, fName, lName, email, photo);
      } else {
        email = await getUserEmailDialog();
        if (validator.email(email)) {
          socialLogin('', fbId, fName, lName, email, photo);
        }
      }
    } else {
      Utils().showMessageDialog(context, "Error", httpResponse.error);
    }
  }

  Future<String> getUserEmailDialog() async {
    final _emailFormKey = GlobalKey<FormState>();
    TextEditingController socialEmailController = new TextEditingController();
    Dialog emailDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
            key: _emailFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text(
                    "We couldn't get email id, please enter your email id.",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Email Id"),
                      TextFormField(
                        controller: socialEmailController,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                             border: OutlineInputBorder(
                               borderSide: BorderSide(
                                 width: 5.0
                               )
                             ),prefixIcon: Icon(Icons.email)),
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
                  margin: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (_emailFormKey.currentState.validate()) {
                          Navigator.of(context).pop(socialEmailController.text);
                        }
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
    String email = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => emailDialog);
    return email;
  }

  socialLogin(String googleId, String fbId, String fName, String lName,
      String email, String photo) async {
    var data = {
      'email': email,
      'googleid': googleId,
      'fbid': fbId,
      'first_name': fName,
      'last_name': lName,
      'profile_pic': photo ?? '',
      'user_role_id': userRoleId
    };
    print('data : $data');
    HttpResponse httpResponse =
        await MyHttpClient(context).post(UrlUtils.SOCIAL_LOGIN, data);
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
    PrefsUtils.setStringPreference(AppConstant.USER_ROLE_ID, data.user_role_id);
    PrefsUtils.setStringPreference(AppConstant.USER_ID, data.user_id);
    PrefsUtils.setStringPreference(AppConstant.F_NAME, data.first_name);
    PrefsUtils.setStringPreference(AppConstant.L_NAME, data.last_name);
    PrefsUtils.setStringPreference(AppConstant.USER_EMAIL, data.user_email);
    PrefsUtils.setStringPreference(AppConstant.USER_PHONE, data.user_phone);
    PrefsUtils.setStringPreference(
        AppConstant.USER_PROFILE_PIC, data.user_profile_pic);
    if (data.user_role_id == AppConstant.USER_ROLE_ID_VAL) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/user_home', ModalRoute.withName('/'));
    } else if (data.user_role_id == AppConstant.VENDOR_ROLE_ID_VAL) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/vendor_home', ModalRoute.withName('/'));
    }
  }
}
