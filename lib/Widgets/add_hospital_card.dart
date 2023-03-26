import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccination_mangement/Controllers/Home/admin_controller.dart';

class AddHospitalCard extends StatelessWidget {
  final String hospitalName;
  final String contactNo;
 // final String hospitalId;
  final bool allow;
  final String status;

  AddHospitalCard({
    required this.hospitalName,
    required this.contactNo,
   // required this.hospitalId,
    required this.allow,
    required this.status,
  
  });

  @override
  Widget build(BuildContext context) {
    AdminController controller =Get.put(AdminController());
    if(status!='accept'){
      return SizedBox();
    }
    else {
return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.grey))),
            child: Icon(Icons.local_hospital, color: Colors.grey),
          ),
          title: Text(
            hospitalName,
            style: TextStyle(
                color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5.0),
              Text(
                contactNo,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 5.0),
              // Text(
              //   hospitalId,
              //   style: TextStyle(color: Colors.grey),
              // )
            ],
          ),
          trailing: allow==true
              ?  ElevatedButton(
                  onPressed: () async {
                    await controller.AddHospitalUpdate(name:hospitalName,status:  false);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red)),
                  child: Text("Remove"),
                )
              : ElevatedButton(
                  onPressed: () async {
                    await controller.AddHospitalUpdate(name:hospitalName,status:  true);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green)),
                  child: Text("ADD"),
                ),
        ),
      ),
    );
    }
    
  }
}
