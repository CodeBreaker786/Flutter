import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../fonts.dart';

class BuildProfileBottomList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text("GENERAL",
                style: googleTextStyle(UiColors.lightblue, 15,
                    fontWeight: FontWeight.w300))),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(9)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: UiColors.secondary2,
                      borderRadius: BorderRadius.circular(9)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Profile Settings",
                      style: googleTextStyle(UiColors.hardblue, 18,
                          fontWeight: FontWeight.w200)),
                  Text("Update and modify your profile",
                      style: googleTextStyle(UiColors.lightblue, 14,
                          fontWeight: FontWeight.w200)),
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(9)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: UiColors.secondary2,
                      borderRadius: BorderRadius.circular(9)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Privacy",
                      style: googleTextStyle(UiColors.hardblue, 18,
                          fontWeight: FontWeight.w200)),
                  Text("Change your password",
                      style: googleTextStyle(UiColors.lightblue, 14,
                          fontWeight: FontWeight.w200))
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(9)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: UiColors.secondary2,
                      borderRadius: BorderRadius.circular(9)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Notifications",
                      style: googleTextStyle(UiColors.hardblue, 18,
                          fontWeight: FontWeight.w200)),
                  Text("Change your notification settings",
                      style: googleTextStyle(UiColors.lightblue, 14,
                          fontWeight: FontWeight.w200))
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                ),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            child: Text("CHART",
                style: googleTextStyle(UiColors.lightblue, 15,
                    fontWeight: FontWeight.w300))),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(9)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: UiColors.secondary2,
                      borderRadius: BorderRadius.circular(9)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Profile Settings",
                      style: googleTextStyle(UiColors.hardblue, 18,
                          fontWeight: FontWeight.w200)),
                  Text("Update and modify your profile",
                      style: googleTextStyle(UiColors.lightblue, 14,
                          fontWeight: FontWeight.w200))
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(9)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: UiColors.secondary2,
                      borderRadius: BorderRadius.circular(9)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Profile Settings",
                      style: googleTextStyle(UiColors.hardblue, 18,
                          fontWeight: FontWeight.w200)),
                  Text("Update and modify your profile",
                      style: googleTextStyle(UiColors.lightblue, 14,
                          fontWeight: FontWeight.w200))
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
