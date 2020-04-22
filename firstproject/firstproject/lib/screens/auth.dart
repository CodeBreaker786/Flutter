import 'package:dsaa/models/AuthModel.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        body: isLoding
            ? bodyProgress
            : Container(
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
                          const SizedBox(height: 40.0),
                          OutlineButton.icon(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            icon: Icon(FontAwesomeIcons.google,
                                color: Theme.of(context).primaryColor),
                            label: Text("Continue with Google"),
                            onPressed: () {},
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      child: (!formVisible)
                          ? null
                          : Container(
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
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
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
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
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
                                      duration: Duration(milliseconds: 300),
                                      child: _formsIndex == 1
                                          ? Container(
                                              margin:
                                                  const EdgeInsets.all(16.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: ListView(
                                                shrinkWrap: true,
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                children: <Widget>[
                                                  TextField(
                                                    controller: email,
                                                    decoration: InputDecoration(
                                                      hintText: "Enter email",
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10.0),
                                                  TextField(
                                                    controller: password,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Enter password",
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10.0),
                                                  RaisedButton(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    textColor: Colors.white,
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    child: Text("Login"),
                                                    onPressed: () async {
                                                      var response = await auth
                                                          .signInWithEmailAndPassword(
                                                              email.text,
                                                              password.text,
                                                              context)
                                                          .then((value) {
                                                        setState(() {});
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              margin:
                                                  const EdgeInsets.all(16.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: ListView(
                                                shrinkWrap: true,
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                children: <Widget>[
                                                  TextField(
                                                    controller: name,
                                                    decoration: InputDecoration(
                                                      hintText: "Enter Name",
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10.0),
                                                  TextField(
                                                    controller: email,
                                                    decoration: InputDecoration(
                                                      hintText: "Enter Email",
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10.0),
                                                  TextField(
                                                    obscureText: true,
                                                    controller: password,
                                                    decoration: InputDecoration(
                                                      hintText: "password",
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10.0),
                                                  RaisedButton(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    textColor: Colors.white,
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    child: Text("Signup"),
                                                    onPressed: () {
                                                      setState(() {
                                                        isLoding = true;
                                                      });
                                                      auth
                                                          .registerWithEmailAndPassword(
                                                              name.text,
                                                              email.text,
                                                              password.text,
                                                              context)
                                                          .then((value) {
                                                        print("success");
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                    )
                  ],
                ),
              ));
  }

  var bodyProgress = new Container(
    child: new Stack(
      children: <Widget>[
        new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.white70,
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.blue[200],
                borderRadius: new BorderRadius.circular(10.0)),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      "loading.. wait...",
                      style: new TextStyle(color: Colors.white),
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
