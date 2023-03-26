
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';


 customToast({message}){
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      webShowClose: true,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
  );
}