// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccination_mangement/Controllers/controllers.dart';
import 'package:vaccination_mangement/Model/appointment_model.dart';
import 'package:vaccination_mangement/View/Home/hospital_home_view.dart';
import 'package:vaccination_mangement/View/Home/user_home_view.dart';
import 'package:vaccination_mangement/Widgets/custom_toast.dart';
import 'package:vaccination_mangement/storage.dart';

import 'Model/child_model.dart';
import 'Model/user_model.dart';

class FirebaseService {
  final userCollection = FirebaseFirestore.instance.collection('user');
  final childCollection = FirebaseFirestore.instance.collection('child');
  final appointmentCollection =
      FirebaseFirestore.instance.collection('appointment');

  //Register user.....................
  registerUser({data}) async {
    var result = await userCollection.add(data);
    await customToast(message: 'Register Successfully With id ${result.id}');
    await customToast(message: 'Please Login Now');
  }

  //login user........................
  loginUser({email, password}) async {
    final querySnapshot = await userCollection
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();
    if (querySnapshot.docs.length > 0) {
      Storage().storeID(userid: querySnapshot.docs[0].id);
      customToast(message: 'Welcome in Vaccination Center');
      String role = querySnapshot.docs[0].data()['role'];
      if (role == 'user') {
        Get.to(const UserHomeView(),
            duration: Duration(milliseconds: 500),
            transition: Transition.rightToLeft);
      }
      if (role == 'hospital') {
        Get.to(const HospitalHomeView(),
            duration: Duration(milliseconds: 500),
            transition: Transition.rightToLeft);
      }
    } else {
      customToast(message: 'Wrong Email or Password');
    }
  }

  //submit child
  submitChild({data}) async {
    var result = await childCollection.add(data);
    await customToast(message: 'Child Added Successfully');
  }

  Future<bool> isChildAdded(String parentId, String childName) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('child') // Replace with your collection name
          .where('parentid', isEqualTo: parentId)
          .where('childname', isEqualTo: childName)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking child existence: $e');
      return false; // Return false in case of any error or if the child doesn't exist
    }
  }


  Future<bool> isAppointmentAdded(String parentId, String childName) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('appointment') // Replace with your collection name
          .where('parentId', isEqualTo: parentId)
          .where('childName', isEqualTo: childName)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking child existence: $e');
      return false; // Return false in case of any error or if the child doesn't exist
    }
  }



  //get name..........................
  getName() async {
    final prefs = await SharedPreferences.getInstance();
    String? userid = await prefs.getString('userid');
    final DocumentSnapshot userDoc = await userCollection.doc(userid).get();
    return userDoc.get('name');
  }

  //get all childs
  Future<List<Child>> getAllChildren(String role) async {
    final prefs = await SharedPreferences.getInstance();
    String? userid = await prefs.getString('userid');
    List<Child> children = [];
    QuerySnapshot? querySnapshot;
    if (role == 'user') {
      querySnapshot =
          await childCollection.where('parentid', isEqualTo: userid).get();
    } else {
      querySnapshot =
          await childCollection.where('parentid', isNotEqualTo: userid).get();
    }

    querySnapshot.docs.forEach((document) {
      Child child = Child(
        childName: document['childname'],
        parentName: document['parentname'],
        dateOfBirth: document['dateofbirth'].toDate(),
        parentId: document['parentid'],
        hospitalname: document['hospitalname'],
        id: document.id,
      );
      children.add(child);
    });

    return children;
  }

  //Submit Appointment
  bookAppointment({data}) async {
    var result = await appointmentCollection.add(data);
    await customToast(message: 'Appointment Booked Successfully');
  }

  //get all childs
  Future<List<ChildAppointment>> getAllAppointment(String type) async {
    final prefs = await SharedPreferences.getInstance();
    String? userid = await prefs.getString('userid');
    List<ChildAppointment> appointments = [];
    QuerySnapshot? querySnapshot;
    if (type == 'user') {
      querySnapshot = await appointmentCollection
          .where('parentId', isEqualTo: userid)
          .get();
    } else if (type == 'admin') {
      querySnapshot = await appointmentCollection
          .where('parentId', isNotEqualTo: userid)
          .get();
    } else {
      print('.....Hospital name: ${type}');
      querySnapshot = await appointmentCollection
          .where('hospitalName', isEqualTo: type)
          .get();
    }

    querySnapshot.docs.forEach((document) {
      ChildAppointment appoint = ChildAppointment(
          childName: document['childName'],
          parentName: document['parentName'],
          parentId: document['parentId'],
          bookDate: document['bookDate'].toDate(),
          appointmentDate: document['appointment_date'].toDate(),
          hospitalName: document['hospitalName'],
          status: document['status'],
          hospitalId: document['hospitalId'],

      );
      appointments.add(appoint);
    });

    return appointments;
  }

  //get all hospital user
  Future<List<User>> getAllHospital() async {
    List<User> hospitals = [];
    QuerySnapshot querySnapshot =
        await userCollection.where('role', isEqualTo: 'hospital').get();
    querySnapshot.docs.forEach((document) {
      User hospital = User(
        userid: document.id,
        name: document['name'],
        email: document['email'],
        phone: document['phone'],
        status: document['status'],
        allow: document['allow'],
      );
      hospitals.add(hospital);
    });
    print('Total Hospitals ${hospitals.length}');
    return hospitals;
  }

  updateHospitalStatus({userid, newStatus}) {
    final userRef = userCollection.doc(userid);
    userRef.update({'status': newStatus});
    customToast(message: 'Status Updated');
  }

  updateChildData(String id, Child child) {
    print('ID______________________$id');
    final userRef = childCollection.doc(id);
    userRef.update({
      'childname': child.childName,
      'dateofbirth': child.dateOfBirth,
      'hospitalname': child.hospitalname
    });
    customToast(message: 'Child Update');
    Get.find<UserController>().updateDisplay(currentView: 'view childs');
  }

  Future<List<Map<String, dynamic>>> getRegisterHospitals() async {
    final Query acceptedHospitalsQuery = userCollection
        .where('status', isEqualTo: 'accept')
        .where('role', isEqualTo: 'hospital')
        .where('allow', isEqualTo: true);
    final List<Map<String, dynamic>> acceptedHospitalsList = [];
    await acceptedHospitalsQuery.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final hospitalMap = {
          'hospitalID': doc.id,
          'hospitalName': doc['name'], // add type cast to String
        };
        acceptedHospitalsList.add(hospitalMap);
      });
    });
    print('Total Accepted Hospitals: ${acceptedHospitalsList.length}');
    return acceptedHospitalsList;
  }

  Future<void> ADDupdateStatus({name, status}) async {
    await userCollection
        .where('role', isEqualTo: 'hospital')
        .where('name', isEqualTo: name)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        await userCollection.doc(doc.id).update({'allow': status});
      });
    });
  }

//__________________update appointment status
  Future<void> updateAppointmentStatus({childName, parentId, status, datetime}) async {
    if(status=='rejected' || status=='closed')
      {
        await appointmentCollection
            .where('childName', isEqualTo: childName)
            .where('parentId', isEqualTo: parentId)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) async {
            await appointmentCollection.doc(doc.id).update({'status': status,});
          });
        });
      }
    else {
      await appointmentCollection
          .where('childName', isEqualTo: childName)
          .where('parentId', isEqualTo: parentId)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          await appointmentCollection.doc(doc.id).update({'status': status, 'appointment_date': datetime});
        });
      });
    }


  }

  //___________________Delete Child

  deletChild(
    String id,
  ) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final DocumentReference documentRef = _firestore.doc('child/$id');
    documentRef.delete().then((value) {
      print("Document deleted successfully");
    }).catchError((error) {
      print("Failed to delete document: $error");
    });
  }

  Future<List<ChildAppointment>> searchAppointment(
      DateTime date, String hospitalName) async {
    final targetDate = date;
    final timestamp = Timestamp.fromDate(
        DateTime(targetDate.year, targetDate.month, targetDate.day));
    final prefs = await SharedPreferences.getInstance();
    String? userid = await prefs.getString('userid');
    List<ChildAppointment> appointments = [];
    QuerySnapshot? querySnapshot = await appointmentCollection
        .where('hospitalName', isEqualTo: hospitalName)
        .where('appointment_date', isGreaterThan: timestamp)
        .get();
    querySnapshot.docs.forEach((document) {
      ChildAppointment? appoint =  ChildAppointment(
          childName: document['childName'],
          parentName: document['parentName'],
          parentId: document['parentId'],
          bookDate: document['bookDate'].toDate(),
          appointmentDate: document['appointment_date'].toDate(),
          hospitalName: document['hospitalName'],
          status: document['status'],
          hospitalId: document['hospitalId']);
      appointments.add(appoint);
    });

    return appointments;
  }
}
