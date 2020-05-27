import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uiproject/colors.dart';
import 'package:uiproject/screens/expenses/chart.dart';

import '../../fonts.dart';
import 'duration_month.dart';
import 'income_and_expense_row.dart';

class Expense extends StatefulWidget {
  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.greyshade,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 75, left: 24, right: 24, bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Expenses",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                        color: UiColors.hardblue),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.credit_card,
                      color: Colors.blue,
                      size: 30,
                    ),
                    color: Colors.white,
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                              text: 'Card Balance\n',
                              style: googleTextStyle(UiColors.hardblue, 13,
                                  fontWeight: FontWeight.w200),
                            ),
                            TextSpan(
                              text: '\$6,390',
                              style: googleTextStyle(UiColors.hardblue, 30,
                                  fontWeight: FontWeight.w900),
                            ),
                          ])),
                  BuildIncomeAndExpenseRow(
                    income: "\$3,14",
                    expense: "\$3,14",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 38,
            ),
            Container(
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      height: 32,
                      width: 101,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Monthly',
                              style: googleTextStyle(UiColors.hardblue, 13,
                                  fontWeight: FontWeight.w200),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: UiColors.hardblue,
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  Expanded(
                    child: Container(
                      height: 32,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          BuildMonthRow(
                            month: "Jan",
                          ),
                          BuildMonthRow(
                            month: 'Feb',
                          ),
                          BuildMonthRow(
                            month: 'Mar',
                          ),
                          BuildMonthRow(
                            month: 'Apr',
                          ),
                          BuildMonthRow(
                            month: 'May',
                          ),
                          BuildMonthRow(
                            month: 'Jun',
                          ),
                          BuildMonthRow(
                            month: 'Jul',
                          ),
                          BuildMonthRow(
                            month: 'Aug',
                          ),
                          BuildMonthRow(
                            month: 'Sep',
                          ),
                          BuildMonthRow(
                            month: 'Oct',
                          ),
                          BuildMonthRow(
                            month: 'Nov',
                          ),
                          BuildMonthRow(
                            month: 'Dec',
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(height: 375, child: HomePage())
          ],
        ),
      ),
    );
  }
}
