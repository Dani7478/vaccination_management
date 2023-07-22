import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart';
import 'package:vaccination_mangement/Widgets/custom_toast.dart';
import '../../Model/appointment_model.dart';
import '../../Model/child_model.dart';
import '../../Model/user_model.dart';
import '../../firebase_service.dart';
import 'package:share_plus/share_plus.dart';
class AdminController extends GetxController {

  String hospitalname = 'Pending....';
  String display = 'view hospital';
  int totalAppointment=0;

  updateDisplay({currentDisplay}){
    display=currentDisplay;
    getHospitalList();
    getAllChilds();
    calculateAppointment();
    print(display);
    update();
  }

  //_______________________on init
  @override
  void onInit() {
    getHospitalList();
    getAllChilds();
    getAllAppointment();
    super.onInit();
  }

  List<User> hospitalsList=[];
  getHospitalList() async {
    hospitalsList= await FirebaseService().getAllHospital();
    update();
  }

  updateHosStatus({id,status}) async {
   await FirebaseService().updateHospitalStatus(userid:id,newStatus: status );
   await getHospitalList();
   update();
  }


  List<Child> childslist=[];
  getAllChilds() async {
    childslist= await FirebaseService().getAllChildren('admin');
    print('child length ${childslist.length}');
    update();
  }

   //______________________all appointment
  List<ChildAppointment> allAppointmentsList=[];
  getAllAppointment() async {
    allAppointmentsList=await  FirebaseService().getAllAppointment('admin');
    print('Appoint list : ${allAppointmentsList.length}');
    update();
  }

  AddHospitalUpdate({name,status}) async {
    await FirebaseService().ADDupdateStatus(name: name,status: status);
    
    if(status==false){
        customToast(message: 'Hospital Removed');
    }else {
       customToast(message: 'Hospital Added');
    }
     await updateDisplay(currentDisplay: display);
  }

  calculateAppointment() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('appointment')
          .get();

      totalAppointment = querySnapshot.docs.length;
      update();
    } catch (e) {
      print('Error calculating appointments count: $e');
    }
  }


  //_____________________________________Save Appointments
  void saveAppointmentsAsPdf(BuildContext context) async {
    // Fetch the data again to ensure you have the latest data
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('appointment').get();

    // Generate PDF
    final pdf = pw.Document();
    for (var doc in snapshot.docs) {
      String id = doc.id;
      String childName = doc['childName'];
      String parentName = doc['parentName'];
      String hospitalNamee = doc['hospitalName'];
      String bookDate = doc['bookDate'].toDate().toString();
      String appointmentData = doc['appointment_date'].toDate().toString();
      String status = doc['status'].toString();
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('ID: $id'),
              pw.Text('Child Name: $childName'),
              pw.Text('Parent Name: $parentName'),
              pw.Text('Hospital Name: $hospitalNamee'),
              pw.Text('Book Date: $bookDate'),
              pw.Text('Appointment Date: $appointmentData'),
              pw.Text('Appointment Status: $status'),
              pw.Divider(),
            ],
          ),
        ),
      );
    }


    final output = await getExternalStorageDirectory();
    debugPrint(output?.path);
    final file = File('${output!.path}/appointments.pdf');
    await file.writeAsBytes(await pdf.save());

    customToast(message: 'PDF file saved at: ${file.path}');
    Share.shareFiles([file.path], text: 'Sharing the PDF file');

    // Show a snackbar with the file path after saving the PDF
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('PDF file saved at: ${file.path}'),
    //   ),
    // );
  }
}


