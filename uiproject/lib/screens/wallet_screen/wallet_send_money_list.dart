import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors.dart';

class BuildSendMoneyList extends StatelessWidget {
  String image;
  String name;
  Function callBack;
  BuildSendMoneyList({this.image, this.name, this.callBack});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
          margin: EdgeInsets.only(left: 12),
          height: 100,
          width: 90,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(image: AssetImage(image)),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: UiColors.lightblue,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                )
              ],
            ),
          )),
    );
  }
}
