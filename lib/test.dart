import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccination_mangement/Widgets/custom_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class MyDateTimePickerApp extends StatefulWidget {
  @override
  _MyDateTimePickerAppState createState() => _MyDateTimePickerAppState();
}

class _MyDateTimePickerAppState extends State<MyDateTimePickerApp> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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

    // Save the selected date and time as a timestamp in Firestore
    final firestoreInstance = FirebaseFirestore.instance;
    final timestamp = Timestamp.fromDate(selectedDate);
    firestoreInstance.collection('selected_dates').add({
      'timestamp': timestamp,
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Date & Time Picker Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Selected Date & Time: ${selectedDate.toLocal()}',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveAppointmentsAsPdf(context),
                child: Text('Select Date & Time'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Function to save appointments as a PDF
  void _saveAppointmentsAsPdf(BuildContext context) async {
    // Fetch the data again to ensure you have the latest data
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('appointment').get();

    // Generate PDF
    final pdf = pw.Document();
    for (var doc in snapshot.docs) {
      String childName = doc['childName'];
      String hospital = doc['hospitalName'];
      String status = doc['status'];
      debugPrint('$childName $hospital $status');
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Child Name: $childName'),
              pw.Text('hospitalName: $hospital'),
              pw.Text('status: $status'),
              pw.Divider(),
            ],
          ),
        ),
      );
    }
    debugPrint('_______________________________________Testing');
    // Save the PDF to the phone's storage
    // final output = await getExternalStorageDirectory();
    // final file = File('${output?.path}/appointments.pdf');
    // await file.writeAsBytes(await pdf.save());

    final output = await getExternalStorageDirectory();
    debugPrint(output?.path);
    final file = File('${output!.path}/example.pdf');
    await file.writeAsBytes(await pdf.save());

    customToast(message: 'PDF file saved at: ${file.path}');

    // Show a snackbar with the file path after saving the PDF
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('PDF file saved at: ${file.path}'),
    //   ),
    // );
  }
}
