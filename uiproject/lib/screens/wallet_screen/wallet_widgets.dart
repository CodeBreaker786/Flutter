import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors.dart';

TextStyle googleTextStyle(Color color, double size,
    {FontWeight fontWeight = FontWeight.w100}) {
  return GoogleFonts.poppins(
      color: color, fontSize: size, fontWeight: fontWeight);
}

Widget buildWalletCard(
    {int number, String name, Function callBack, Color color}) {
  return GestureDetector(
    onTap: callBack,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: color,
        margin: EdgeInsets.only(left: 24, right: 17),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
            width: 300,
            child: Container(
              margin: EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: 40,
                          left: 24,
                          child: Container(
                            height: 33,
                            width: 37,
                            decoration: BoxDecoration(
                                color: UiColors.yellowcircle,
                                borderRadius: BorderRadius.circular(40)),
                          )),
                      Positioned(
                          top: 40,
                          child: Container(
                            height: 33,
                            width: 37,
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(.8),
                                borderRadius: BorderRadius.circular(70)),
                          )),
                    ],
                  )),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Image.asset('icons/113.png')),
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          name,
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.white),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "11/22",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    ),
  );
}

buildAppBarTitle() {
  return RichText(
      text: TextSpan(
          style: googleTextStyle(
            UiColors.hardblue,
            22,
          ),
          children: [
        TextSpan(
            text: 'Wallet ', style: TextStyle(fontWeight: FontWeight.w600)),
        TextSpan(
            text: 'for ',
            style: TextStyle(
                fontSize: 15,
                color: UiColors.lightblue,
                fontWeight: FontWeight.w600)),
        TextSpan(
            text: 'Axess Paltinum ',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        TextSpan(
            text: 'Card',
            style: TextStyle(
                fontSize: 15,
                color: UiColors.lightblue,
                fontWeight: FontWeight.w600)),
      ]));
}

Widget buildIncomeAndExpenseRow(
    {@required String income, @required String expense}) {
  return Row(
    children: <Widget>[
      Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            color: Colors.green.withOpacity(.2),
            borderRadius: BorderRadius.circular(8)),
        child: Image.asset('icons/up.png'),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Income',
              style: GoogleFonts.poppins(
                  color: UiColors.lightblue,
                  fontWeight: FontWeight.w200,
                  fontSize: 14),
            ),
            Text(
              income,
              style: GoogleFonts.poppins(
                  color: UiColors.hardblue,
                  fontWeight: FontWeight.w200,
                  fontSize: 14),
            )
          ],
        ),
      ),
      SizedBox(
        width: 45,
      ),
      Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            color: Colors.green.withOpacity(.2),
            borderRadius: BorderRadius.circular(8)),
        child: Image.asset('icons/down.png'),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Expense',
              style: GoogleFonts.poppins(
                  color: UiColors.lightblue,
                  fontWeight: FontWeight.w200,
                  fontSize: 14),
            ),
            Text(
              expense,
              style: GoogleFonts.poppins(
                  color: UiColors.hardblue,
                  fontWeight: FontWeight.w200,
                  fontSize: 14),
            )
          ],
        ),
      )
    ],
  );
}

buildDayWeekMounthYear({@required duration, value, callBack}) {
  return GestureDetector(
    onTap: callBack,
    child: Container(
      decoration: BoxDecoration(
          color: UiColors.secondary2, borderRadius: BorderRadius.circular(6)),
      height: 26,
      width: 72,
      child: Center(
        child: Text(
          duration,
          style: googleTextStyle(UiColors.darkblue, 13,
              fontWeight: FontWeight.w300),
        ),
      ),
    ),
  );
}
