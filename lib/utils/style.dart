import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
getStyle({
  Color color=Colors.white,
 FontWeight fontWeight=FontWeight.w400,
  double fontSize=18,String family="Roboto",}){

  return GoogleFonts.getFont(family).copyWith(
    fontSize: fontSize,
    fontWeight: fontWeight,
    
    color: color
    
  );
  
}