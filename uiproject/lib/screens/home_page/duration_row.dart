import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../fonts.dart';

class BuildDayWeekMonthYear extends StatelessWidget {
  BuildDayWeekMonthYear({@required this.duration, this.value, this.callBack});
  String duration;
  int value;
  Function callBack;
  @override
  Widget build(BuildContext context) {
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
}
