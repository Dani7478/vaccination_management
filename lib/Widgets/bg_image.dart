

 import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Widget bgImage( {child, context}){
  Size size=MediaQuery.of(context).size;
  return Container(
    height: size.height,
    width: size.width,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/bg.jpeg'),
        fit: BoxFit.cover
      )
    ),
    child: child,
  );
 }