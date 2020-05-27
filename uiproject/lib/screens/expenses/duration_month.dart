import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../fonts.dart';

class BuildMonthRow extends StatelessWidget {
  String month;
  int value;
  Function callBack;
  BuildMonthRow({@required this.month, this.value, this.callBack});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
        margin: EdgeInsets.only(left: 21),
        decoration: BoxDecoration(
            color: UiColors.secondary2, borderRadius: BorderRadius.circular(6)),
        height: 32,
        width: 38,
        child: Center(
          child: Text(
            month,
            style: googleTextStyle(UiColors.darkblue, 13,
                fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
    ;
  }
}
