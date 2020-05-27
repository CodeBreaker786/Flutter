import 'dart:ui';

/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';

class AuthTwoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/dsa.jpg'), fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.all(48.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 48.0),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10.0)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 0.5,
                    sigmaY: 0.5,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 64,
                        color: Colors.grey.shade800,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "DSA",
                        style: TextStyle(
                            color: Colors.deepOrange.shade700,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                          "Nutritionally balanced, easy to cook recipes. Quality fresh local ingredients.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0)),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 0,
                          highlightElevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text("Create Account"),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Text.rich(TextSpan(children: [
                        TextSpan(text: "Already have account? "),
                        WidgetSpan(
                            child: InkWell(
                          onTap: () {
                            print("Login tapped");
                          },
                          child: Text("Log in",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ))
                      ])),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
