import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constant/colors.dart';

Widget topHeader(Size size){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 80,
        child: Container(
          width: size.width,
          child: Image.asset(
            'assets/images/covid-19-header.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      Expanded(
        flex: 20,
        child: Container(
          width: size.width,
          child: Text(
            'Vaccination Management System for Children',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: size.width*0.04,
              fontWeight: FontWeight.w800,
              color: covidTextColor,
            ),
          ),
        ),
      ),
    ],
  );
}