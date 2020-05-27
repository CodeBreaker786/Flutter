import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:uiproject/colors.dart';
import 'package:uiproject/screens/wallet_screen/wallet_send_money_list.dart';
import 'package:uiproject/screens/wallet_screen/wallet_widgets.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.greyshade,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildAppBarTitle(),
                    Icon(Icons.account_balance_wallet),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildWalletCard(
                          name: 'JONATHAN DAVIS',
                          callBack: null,
                          color: UiColors.darkblue);
                    }),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Remaining Amount ",
                          style: GoogleFonts.poppins(
                              color: UiColors.hardblue,
                              fontSize: 14,
                              fontWeight: FontWeight.w200)),
                      Text("%38 ",
                          style: GoogleFonts.poppins(
                              color: UiColors.hardblue,
                              fontSize: 14,
                              fontWeight: FontWeight.w200)),
                    ]),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: LinearPercentIndicator(
                  lineHeight: 5.0,
                  percent: 0.70,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.greenAccent,
                  backgroundColor: Colors.red,
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: buildIncomeAndExpenseRow(
                    income: "\$3,14",
                    expense: "\$3,14",
                  )),
              Container(
                margin: const EdgeInsets.only(
                  left: 24.0,
                ),
                child: Text(
                  'Send Money to',
                  style: GoogleFonts.poppins(
                      color: UiColors.hardblue,
                      fontWeight: FontWeight.w200,
                      fontSize: 22),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 24, left: 24),
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    DottedBorder(
                      strokeCap: StrokeCap.round,
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      dashPattern: [8, 8],
                      radius: Radius.circular(10),
                      color: UiColors.secondary2,
                      child: Container(
                        height: 100,
                        width: 90,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: UiColors.darkblue,
                                ),
                              ),
                              Text(
                                "Add new contacts",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: UiColors.lightblue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              )
                            ]),
                      ),
                    ),
                    BuildSendMoneyList(
                        name: " josie \n maran",
                        image: 'icons/profile.jpg',
                        callBack: null),
                    BuildSendMoneyList(
                        name: " josie \n  maran",
                        image: 'icons/profile.jpg',
                        callBack: null),
                    BuildSendMoneyList(
                        name: " josie \n marrn",
                        image: 'icons/profile.jpg',
                        callBack: null),
                    BuildSendMoneyList(
                        name: " josie \n maran",
                        image: 'icons/profile.jpg',
                        callBack: null)
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 24.0,
                ),
                child: Text(
                  'Transactions',
                  style: GoogleFonts.poppins(
                      color: UiColors.hardblue,
                      fontWeight: FontWeight.w200,
                      fontSize: 22),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildDayWeekMounthYear(duration: 'Day'),
                    buildDayWeekMounthYear(duration: 'week'),
                    buildDayWeekMounthYear(duration: 'month'),
                    buildDayWeekMounthYear(duration: 'Year'),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9)),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(9)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Profile Settings",
                            style: googleTextStyle(
                              UiColors.hardblue,
                              18,
                            )),
                        Text("Update and modify your profile",
                            style: googleTextStyle(
                              UiColors.lightblue,
                              14,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
