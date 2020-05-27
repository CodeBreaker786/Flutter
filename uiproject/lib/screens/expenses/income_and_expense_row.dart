import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildIncomeAndExpenseRow extends StatelessWidget {
  BuildIncomeAndExpenseRow({@required this.income, @required this.expense});
  String income;
  String expense;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.2),
                  borderRadius: BorderRadius.circular(6)),
              child: Image.asset('icons/up1x.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                income,
                style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontWeight: FontWeight.w200,
                    fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: <Widget>[
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.2),
                  borderRadius: BorderRadius.circular(6)),
              child: Image.asset('icons/down1x.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                expense,
                style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontWeight: FontWeight.w200,
                    fontSize: 14),
              ),
            ),
          ],
        )
      ],
    );
  }
}
