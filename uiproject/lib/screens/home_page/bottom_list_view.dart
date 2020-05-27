import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../fonts.dart';

class BottomListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(9)),
                    child: Image.asset('icons/shell.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Shell",
                        style: googleTextStyle(UiColors.hardblue, 18,
                            fontWeight: FontWeight.w200)),
                    Text("17 Monday june",
                        style: googleTextStyle(UiColors.lightblue, 14,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '-\$35,38',
                      style: googleTextStyle(Colors.red, 18),
                    ))
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
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(9)),
                    child: Image.asset('icons/shell.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Shell",
                        style: googleTextStyle(UiColors.hardblue, 18,
                            fontWeight: FontWeight.w200)),
                    Text("17 Monday june",
                        style: googleTextStyle(UiColors.lightblue, 14,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '-\$35,38',
                      style: googleTextStyle(Colors.red, 18),
                    ))
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
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(9)),
                    child: Image.asset('icons/shell.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Shell",
                        style: googleTextStyle(UiColors.hardblue, 18,
                            fontWeight: FontWeight.w200)),
                    Text("17 Monday june",
                        style: googleTextStyle(UiColors.lightblue, 14,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '-\$35,38',
                      style: googleTextStyle(Colors.red, 18),
                    ))
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
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(9)),
                    child: Image.asset('icons/shell.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Shell",
                        style: googleTextStyle(UiColors.hardblue, 18,
                            fontWeight: FontWeight.w200)),
                    Text("17 Monday june",
                        style: googleTextStyle(UiColors.lightblue, 14,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '-\$35,38',
                      style: googleTextStyle(Colors.red, 18),
                    ))
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
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(9)),
                    child: Image.asset('icons/shell.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Shell",
                        style: googleTextStyle(UiColors.hardblue, 18,
                            fontWeight: FontWeight.w200)),
                    Text("17 Monday june",
                        style: googleTextStyle(UiColors.lightblue, 14,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '-\$35,38',
                      style: googleTextStyle(Colors.red, 18),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
