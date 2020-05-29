import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle googleTextStyle(Color color, double size,
    {FontWeight fontWeight = FontWeight.w200}) {
  return GoogleFonts.poppins(
      color: color, fontSize: size, fontWeight: fontWeight);
}

TextStyle googleChivoTextStyle(Color color, double size,
    {FontWeight fontWeight = FontWeight.w200}) {
  return GoogleFonts.poppins(
      color: color, fontSize: size, fontWeight: fontWeight);
}
