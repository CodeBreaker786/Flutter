import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uiproject/screens/home_page/bottom_list_view.dart';
import 'package:uiproject/screens/home_page/home_page_budget_card.dart';

import '../../colors.dart';
import '../../fonts.dart';
import 'duration_row.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(),
            Positioned(
                child: Container(
              decoration: BoxDecoration(
                color: UiColors.darkblue,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(32)),
              ),
              height: 347,
            )),
            Positioned(
                top: 68,
                right: 0,
                left: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Your Budgets",
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.notifications,
                                size: 30,
                              ),
                              color: Colors.white,
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                      HomePageBudgetCard(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 48,
                              width: 170,
                              decoration: BoxDecoration(
                                  color: UiColors.secondary2,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset('icons/send.png'),
                                  Text(
                                    'Send Money ',
                                    style: googleTextStyle(
                                        UiColors.darkblue, 13,
                                        fontWeight: FontWeight.w200),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 48,
                              width: 170,
                              decoration: BoxDecoration(
                                  color: UiColors.secondary2,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset('icons/calculation.png'),
                                  Text(
                                    'Calculation',
                                    style: googleTextStyle(
                                        UiColors.darkblue, 13,
                                        fontWeight: FontWeight.w200),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Transactions',
                        style: GoogleFonts.poppins(
                            color: UiColors.hardblue,
                            fontWeight: FontWeight.w200,
                            fontSize: 25),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12, bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            BuildDayWeekMonthYear(duration: 'Day'),
                            BuildDayWeekMonthYear(duration: 'week'),
                            BuildDayWeekMonthYear(duration: 'month'),
                            BuildDayWeekMonthYear(duration: 'Year'),
                          ],
                        ),
                      ),
                      BottomListView()
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
