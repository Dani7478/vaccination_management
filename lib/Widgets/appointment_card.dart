import 'package:flutter/material.dart';
import 'package:vaccination_mangement/Controllers/Home/hospital_controller.dart';
import 'package:vaccination_mangement/View/screens.dart';

class AppointmentCard extends StatefulWidget {
  final String childName;
  final String date;
  final String hospitalName;
  final String status;
  final String view;
  final String parentId;

  AppointmentCard(
      {required this.childName,
      required this.date,
      required this.hospitalName,
      required this.status,
      required this.view,
      required this.parentId
      });

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  String? menuSelection;

  @override
  void initState() {
    super.initState();
    menuSelection = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;

    if (widget.status == 'pending') {
      backgroundColor = Colors.orange!;
    } else if (widget.status == 'accepted') {
      backgroundColor = Colors.green!;
    } else {
      backgroundColor = Colors.redAccent!;
    }

    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.childName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  widget.date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Hospital: ${widget.hospitalName}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16.0),
            Text(widget.status,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                )),
            widget.view == 'hospital'
                ? Align(
                    alignment: Alignment.topRight,
                    child: GetBuilder<HospitalController>(
                      init: HospitalController(),
                      builder: (con){
                       return InkWell(
                        onTap: () async {
                          if(widget.status!='accept')  {
                            await con.updateAppointMentSatus(childName: widget.childName, parentId: widget.parentId);
                          }
                        },
                         child: Container(
                                             height: 40,
                                             width: 100,
                                             decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                                             child: Center(
                            child: Text(
                          widget.status=='pending'? 'Done' : 'Completed',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                                             )),
                                           ),
                       );
                      },
                    )
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
