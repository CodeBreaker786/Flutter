import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcuf/models/Authentication.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class AuthPage extends StatefulWidget {
  static final String route = "/authication";

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final auth = AuthService();
  bool isLoding = false;
  int _formsIndex;
  bool formVisible;

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoding ? _buildProgressBar() : _buildAuthicationFrom());
  }

  Widget _buildAuthicationFrom() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/dsa.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.black54,
            child: Column(
              children: <Widget>[
                const SizedBox(height: kToolbarHeight + 40),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Welcome to this awesome login app. \n You are awesome",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                OutlineButton.icon(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  icon: Icon(FontAwesomeIcons.google,
                      color: Theme.of(context).primaryColor),
                  label: Text("Continue with Google"),
                  onPressed: () async {
                    await auth.signInWithGoogle();
                  },
                ),
                const SizedBox(height: 10.0),
                OutlineButton.icon(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  icon: Icon(Icons.fingerprint,
                      color: Theme.of(context).primaryColor),
                  label: Text("Continue with Google"),
                  onPressed: () async {
                    FirebaseAuth _auth = FirebaseAuth.instance;
                    _auth.verifyPhoneNumber(
                        phoneNumber: "+923166788626",
                        timeout: Duration(seconds: 60),
                        verificationCompleted:
                            (AuthCredential credential) async {
                          AuthResult authResult =
                              await _auth.signInWithCredential(credential);

                          FirebaseUser user = authResult.user;

                          if (user != null) {
                          } else {
                            print("ERROR");
                          }
                        },
                        verificationFailed: (AuthException exception) {
                          print("error");
                        },
                        codeSent: (String verification,
                            [int forceResendingToken]) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  title: Text('Enter 6-Digit Code'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        maxLength: 6,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Code',
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                        ),
                                      )
                                    ],
                                  ),
                                  actions: <Widget>[
                                    Text(
                                      "Wait for Automatic Detection!",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.red),
                                    ),
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text("Confirm"),
                                      textColor: Colors.white,
                                      color: Colors.lightBlue,
                                      onPressed: () async {
                                        setState(() {});

                                        AuthCredential credential =
                                            PhoneAuthProvider.getCredential(
                                                verificationId: verification,
                                                smsCode: "12345");
                                        AuthResult result = await _auth
                                            .signInWithCredential(credential);
                                        FirebaseUser user = result.user;
                                        if (user != null) {
                                          print("user is not null");
                                        } else {
                                          print("ERROR: Code mismatch!");
                                        }
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        codeAutoRetrievalTimeout: null);
                  },
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("Login"),
                        onPressed: () {
                          setState(() {
                            formVisible = true;
                            _formsIndex = 1;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.grey.shade700,
                        textColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("Signup"),
                        onPressed: () {
                          setState(() {
                            formVisible = true;
                            _formsIndex = 2;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                  ],
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: (!formVisible)
                ? null
                : Container(
                    key: UniqueKey(),
                    color: Colors.black54,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              textColor: _formsIndex == 1
                                  ? Colors.white
                                  : Colors.black,
                              color: _formsIndex == 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              child: Text("Login"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () {
                                setState(() {
                                  _formsIndex = 1;
                                });
                              },
                            ),
                            const SizedBox(width: 10.0),
                            RaisedButton(
                              textColor: _formsIndex == 2
                                  ? Colors.white
                                  : Colors.black,
                              color: _formsIndex == 2
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              child: Text("Signup"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () {
                                setState(() {
                                  _formsIndex = 2;
                                });
                              },
                            ),
                            const SizedBox(width: 10.0),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  formVisible = false;
                                });
                              },
                            )
                          ],
                        ),
                        Container(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 2000),
                            switchInCurve: Interval(
                              0.3,
                              1,
                              curve: Curves.bounceIn,
                            ),
                            switchOutCurve: Interval(
                              0.7,
                              1,
                              curve: Curves.linear,
                            ),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  child: child, scale: animation);
                            },
                            child: _formsIndex == 1
                                ? _buildLoginPage()
                                : _buildSignUpPage(),
                          ),
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildLoginPage() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            controller: email,
            decoration: InputDecoration(
              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Login"),
            onPressed: () async {
              await auth
                  .signInWithEmailAndPassword(
                      email.text, password.text, context)
                  .then((value) {
                setState(() {});
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpPage() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            controller: name,
            decoration: InputDecoration(
              hintText: "Enter Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: email,
            decoration: InputDecoration(
              hintText: "Enter Email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            controller: password,
            decoration: InputDecoration(
              hintText: "password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Signup"),
            onPressed: () {
              setState(() {
                isLoding = true;
              });
              auth
                  .registerWithEmailAndPassword(
                      name.text, email.text, password.text, context)
                  .then((value) {
                print("success");
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(10.0)),
              width: 300.0,
              height: 200.0,
              alignment: AlignmentDirectional.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: Center(
                      child: Text(
                        "loading.. wait...",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkBioMetricAuth() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error biome trics $e");
    }

    print("biometric is available: $canCheckBiometrics");

    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");
    if (  availableBiometrics.isNotEmpty) {
      availableBiometrics.forEach((ab) {
        print("\ttech: $ab");
      });
    } else {
      print("no biometrics are available");
    }

    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Touch your finger on the sensor to login',
          useErrorDialogs: true,
          stickyAuth: false,
          androidAuthStrings:
              AndroidAuthMessages(signInTitle: "Login to HomePage"));
    } catch (e) {
      print("error using biometric auth: $e");
    }
    // setState(() {
    //   isAuth = authenticated ? true : false;
    // });

    print("authenticated: $authenticated");
  }
}
