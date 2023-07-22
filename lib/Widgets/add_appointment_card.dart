import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccination_mangement/Controllers/controllers.dart';

import '../Model/appointment_model.dart';
import '../firebase_service.dart';

class AddAppointmentCard extends StatelessWidget {
  final String childName;
  final String parentName;
  final String hospital;
  final String id;
  final DateTime dob;

  const AddAppointmentCard({
    Key? key,
    required this.childName,
    required this.parentName,
    required this.hospital,
    required this.id,
    required this.dob,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(childName),
        subtitle: Text('S/D Of ' + parentName),
        trailing: PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: Text("Book Appointment"),
              value: "appointment",
            ),
            // PopupMenuItem(
            //   child: Text("Update"),
            //   value: "update",
            // ),
            // PopupMenuItem(
            //   child: Text("Delete"),
            //   value: "delete",
            // ),
            // PopupMenuItem(
            //   child: Text("Edit"),
            //   value: "edit",
            // ),
          ],
          onSelected: (value) {
            switch (value) {
              case "appointment":
                Get.find<UserController>().bookAppointmrnt(ChildAppointment(
                    childName: childName,
                    parentName: parentName,
                    hospitalName: hospital));
                break;
              case "update":
              // handle update action
                break;
              case "edit":
                Get.find<UserController>().updateEdits(childName, hospital,dob,id);
                Get.find<UserController>().updateDisplay(currentView: 'edit childs');
                break;
              case "delete":
                FirebaseService().deletChild(id);
                Get.find<UserController>().getAllChilds();
                break;
            }
          },
        ),
      ),
    );
  }
}
