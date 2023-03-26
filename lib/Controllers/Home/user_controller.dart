import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccination_mangement/Model/child_model.dart';

import '../../Model/appointment_model.dart';
import '../../firebase_service.dart';

class UserController extends GetxController {
  String username = 'Jhon';
  String display = 'view childs';

  //UPDATE DISPLAY.....................
  updateDisplay({currentView}) {
    display = currentView;
    print(display);
    getAllChilds();
    getAllAppointment();
    updateRegisterHospitals();
    update();
  }

  @override
  void onInit() {
    getName();
    getAllChilds();
    getAllAppointment();
    updateRegisterHospitals();
    super.onInit();
  }

  getName() async {
    username = await FirebaseService().getName();
    parentNameCtrl.text=username;
    print('......................${username}');
    update();
  }


  //____________________date picker
  DateTime? dateOfBirth;
  updateDateOfBirth({newDate}){
    dateOfBirth=newDate;
    update();
  }

  //____________________drop down list
  String? selectedHospital;
  List<String> hospitalList=[];

  updateHospital({newHospital}) async {
    selectedHospital=newHospital;
    update();
  }

  updateRegisterHospitals() async {
    hospitalList.clear();
    List<Map<String, dynamic>> acceptedHospitalsList=await FirebaseService().getRegisterHospitals();
    for(int i=0; i<acceptedHospitalsList.length;i++) {
      hospitalList.add(acceptedHospitalsList[i]['hospitalName']);
    }
     update();
  }
  //____________________Controllers
  TextEditingController childNameCtrl=TextEditingController();
  TextEditingController parentNameCtrl=TextEditingController();
  //______________________child data
  submitChild() async {
    final prefs = await SharedPreferences.getInstance();
   String? parentid= await prefs.getString('userid');

    var child={
      'childname':childNameCtrl.text,
      'parentname': parentNameCtrl.text,
      'dateofbirth':dateOfBirth,
      'hospitalname':selectedHospital,
      'parentid':parentid
    };
    FirebaseService().submitChild(data: child);
  }


 List<Child> childslist=[];
  getAllChilds() async {
    childslist= await FirebaseService().getAllChildren();
    print('child length ${childslist.length}');
    update();
  }

  //_______________book appointment
  bookAppointmrnt(ChildAppointment newAppointment) async {
    final prefs = await SharedPreferences.getInstance();
    String? userid=await prefs.getString('userid');
    var data={
      'childName': newAppointment.childName,
      'parentName': username,
      'parentId': userid,
      'bookDate': DateTime.now(), // set the book date to the current date and time
      'hospitalName': newAppointment.hospitalName,
      'hospitalId': '7890',
      'status': 'pending'
    };
    print(data);
    await FirebaseService().bookAppointment(data: data);
  }

  //______________________all appointment
  List<ChildAppointment> allAppointmentsList=[];
  getAllAppointment() async {
    allAppointmentsList=await  FirebaseService().getAllAppointment('user');
    print('Appoint list : ${allAppointmentsList.length}');
    update();
  }
}
