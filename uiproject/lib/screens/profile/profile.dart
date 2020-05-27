import 'package:flutter/material.dart';
import 'package:uiproject/colors.dart';
import 'package:uiproject/screens/profile/profile_bottom_list.dart';
import 'package:uiproject/screens/profile/profile_card.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: <Widget>[
          Container(),
          Positioned(
              child: Container(
            decoration: BoxDecoration(
              color: UiColors.darkblue,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
            ),
            height: 298,
          )),
          Positioned(
              bottom: 380,
              top: 150,
              right: 20,
              left: 20,
              child: BuildProfileCard()),
          Positioned(
              top: 68,
              right: 24,
              left: 24,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Profile",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 30,
                      ),
                      color: Colors.white,
                      onPressed: () {},
                    )
                  ],
                ),
              )),
          Positioned(
              top: 520,
              left: 20,
              right: 20,
              bottom: 0,
              child: BuildProfileBottomList()),
        ],
      ),
    );
  }
}
