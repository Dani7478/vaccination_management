import 'package:flutter/material.dart';

import '../Constant/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String childName;
  final String date;
  final String time;

  CustomAlertDialog({
    required this.childName,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning, size: 60, color: primaryColor),
          Text(
            'Vaccination Reminder',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: primaryColor),
          ),
          SizedBox(height: 25),
          Text(
            childName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: primaryColor),
          ),
          SizedBox(height: 15),
          Text("Date: $date",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text("Time: $time",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          SizedBox(height: 25,),

          MaterialButton(
            color: primaryColor,
            minWidth: 200,
            onPressed: () => Navigator.pop(context),
            child: Text("OK", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),

    );
  }
}
