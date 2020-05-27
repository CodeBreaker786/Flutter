import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors.dart';

class BuildProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage("icons/profile.jpg")),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(9)),
          ),
          Container(
            margin: EdgeInsets.only(left: 90),
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Ricardo",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          color: UiColors.hardblue),
                    ),
                    Expanded(
                        child: Center(
                            child: Icon(
                      Icons.stars,
                      color: Colors.amber,
                    )))
                  ],
                ),
                Text(
                  'malikfani112@gmail.com',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: UiColors.mailcolor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10)),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: UiColors.secondary2,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: UiColors.secondary2,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: UiColors.secondary2,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: UiColors.secondary2,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
