import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../fonts.dart';

class HomePageBudgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 327,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        style: googleTextStyle(
                          UiColors.hardblue,
                          22,
                        ),
                        children: [
                      TextSpan(
                          text: 'for ',
                          style: TextStyle(
                              fontSize: 15,
                              color: UiColors.lightblue,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: 'Axess Paltinum ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: 'Card',
                          style: TextStyle(
                              fontSize: 15,
                              color: UiColors.lightblue,
                              fontWeight: FontWeight.w600)),
                    ])),
                GestureDetector(
                  child: Text('Add Budget',
                      style: googleTextStyle(Colors.blueAccent, 13)),
                  onTap: () {},
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                'icons/Chart.png',
              ))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.credit_card),
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      softWrap: true,
                      text: TextSpan(
                          style: googleTextStyle(
                            UiColors.hardblue,
                            22,
                          ),
                          children: [
                            TextSpan(
                              text: 'you are spend\n',
                              style: googleTextStyle(UiColors.hardblue, 13,
                                  fontWeight: FontWeight.w200),
                            ),
                            TextSpan(
                              text: '\$6,390\n',
                              style: googleTextStyle(UiColors.hardblue, 30,
                                  fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text: 'of \$',
                              style: googleTextStyle(UiColors.hardblue, 13,
                                  fontWeight: FontWeight.w200),
                            ),
                            TextSpan(
                              text: '3,248',
                              style: googleTextStyle(UiColors.hardblue, 13,
                                  fontWeight: FontWeight.w200),
                            ),
                          ])),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '0%',
                  style: googleTextStyle(UiColors.hardblue, 13,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '100%',
                  style: googleTextStyle(UiColors.hardblue, 13,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: UiColors.darkblue,
                      borderRadius: BorderRadius.circular(2)),
                  height: 4,
                  width: 16,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      color: UiColors.secondary2,
                      borderRadius: BorderRadius.circular(2)),
                  height: 4,
                  width: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: UiColors.secondary2,
                      borderRadius: BorderRadius.circular(2)),
                  height: 4,
                  width: 16,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
