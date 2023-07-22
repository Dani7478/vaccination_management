import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaccination_mangement/Controllers/Home/hospital_controller.dart';
import 'package:vaccination_mangement/View/screens.dart';
import 'package:intl/intl.dart';

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
      required this.parentId});

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

String actualDateFormat = '';

class _AppointmentCardState extends State<AppointmentCard> {
  String? menuSelection;

  @override
  void initState() {
    super.initState();
    menuSelection = widget.status;
  }

  convertToDesiredFormat(String inputString) {
    // Convert the input string to a DateTime object
    DateTime dateTime = DateTime.parse(inputString);

    // Format DateTime to the desired string format: "22 July 2023 9:10 AM"
    actualDateFormat = DateFormat('dd MMMM yyyy h:mm a').format(dateTime);
    setState(() {});
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Timestamp? timestamp;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate == null) return; // User canceled the date picker

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime == null) return; // User canceled the time picker

    setState(() {
      selectedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      selectedTime = pickedTime;
    });
    timestamp = Timestamp.fromDate(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    convertToDesiredFormat(widget.date);
    Color backgroundColor;

    if (widget.status == 'pending') {
      backgroundColor = Colors.orange;
    } else if (widget.status == 'accepted') {
      backgroundColor = Colors.greenAccent;
    } else if (widget.status == 'closed') {
      backgroundColor = Colors.green;
    } else {
      backgroundColor = Colors.redAccent;
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
                widget.status=='accepted' || widget.status=='closed' ? actualDateFormat : '',
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
            Text(widget.status == 'closed' ? 'Completed' : widget.status,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                )),
            widget.view == 'hospital' && widget.status!='closed'
                ? Align(
                    alignment: Alignment.topRight,
                    child: GetBuilder<HospitalController>(
                      init: HospitalController(),
                      builder: (con) {
                        return PopupMenuButton(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              child: Text("Accept"),
                              value: "accept",
                            ),
                            PopupMenuItem(
                              child: Text("Reject"),
                              value: "reject",
                            ),
                            PopupMenuItem(
                              child: Text("Complete"),
                              value: "complete",
                            ),
                            // PopupMenuItem(
                            //   child: Text("Edit"),
                            //   value: "edit",
                            // ),
                          ],
                          onSelected: (value) async {
                            switch (value) {
                              case "accept":
                                await _selectDateTime(context);
                                await con.updateAppointMentSatus(
                                    childName: widget.childName,
                                    parentId: widget.parentId,
                                    status: 'accepted',
                                    datetime: timestamp);
                                break;
                              case "reject":
                                con.updateAppointMentSatus(
                                    childName: widget.childName,
                                    parentId: widget.parentId,
                                    status: 'rejected');
                                break;

                              case "complete":
                                con.updateAppointMentSatus(
                                    childName: widget.childName,
                                    parentId: widget.parentId,
                                    status: 'closed');
                                break;
                            }
                          },
                        );
                        // return InkWell(
                        //  onTap: () async {
                        //    if(widget.status!='accept')  {
                        //      await con.updateAppointMentSatus(childName: widget.childName, parentId: widget.parentId);
                        //    }
                        //  },
                        //   child: Container(
                        //                       height: 40,
                        //                       width: 100,
                        //                       decoration: BoxDecoration(
                        //      color: Colors.green,
                        //      borderRadius: BorderRadius.circular(8)),
                        //                       child: Center(
                        //      child: Text(
                        //    widget.status=='pending'? 'Done' : 'Completed',
                        //    style: TextStyle(color: Colors.white, fontSize: 16),
                        //                       )),
                        //                     ),
                        // );
                      },
                    ))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
