
import 'package:flutter/material.dart';
import 'package:vaccination_mangement/View/screens.dart';

Widget customTextField({hintText, editingCtrl, obscur}) {

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white60
      ),
      child: TextFormField(
      obscureText: obscur,
        controller: editingCtrl,
        decoration: InputDecoration(
        
          hintStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w300
          ),
          hintText: hintText,
          border: InputBorder.none
        ),
        style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w400
        ),
      ),
    ),
  );
}