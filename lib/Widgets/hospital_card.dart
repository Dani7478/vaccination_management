import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccination_mangement/Controllers/Home/admin_controller.dart';

class HospitalCard extends StatelessWidget {
  final String image;
  final String hospitalName;
  final String contactNo;
  final String status;
  final String hospitalid;

  HospitalCard(
      {required this.image,
      required this.hospitalName,
      required this.contactNo,
      required this.status,
        required this.hospitalid
      });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status) {
      case 'accept':
        statusColor = Colors.green;
        break;
      case 'reject':
        statusColor = Colors.red;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      color: statusColor,
      child: InkWell(
        onTap: () {
          // Handle card tap event
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                image,
                height: 120.0,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(height: 16.0),
              Text(
                hospitalName,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                contactNo,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                 GetBuilder<AdminController>(
                   init: AdminController(),
                     builder: (con){
                     return  PopupMenuButton<String>(
                       onSelected: (value) {
                         if(value=='accept'){
                           con.updateHosStatus(id: hospitalid,status: 'accept');
                         }
                         if(value=='reject'){
                           con.updateHosStatus(id: hospitalid,status: 'reject');
                         }
                         if(value=='pending'){
                           con.updateHosStatus(id: hospitalid,status: 'pending');
                         }
                       },
                       itemBuilder: (BuildContext context) {
                         return <PopupMenuEntry<String>>[
                           PopupMenuItem<String>(
                             value: 'accept',
                             child: Text('Accept'),
                           ),
                           PopupMenuItem<String>(
                             value: 'reject',
                             child: Text('Reject'),
                           ),
                           PopupMenuItem<String>(
                             value: 'pending',
                             child: Text('pending'),
                           ),
                           PopupMenuItem<String>(
                             value: 'delete',
                             child: Text('Delete'),
                           ),
                         ];
                       },
                     );
                     })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
