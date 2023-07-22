import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccination_mangement/Model/child_model.dart';
import 'package:vaccination_mangement/Widgets/widgets.dart';

import '../../Model/appointment_model.dart';
import '../../Widgets/custom_dialogue.dart';
import '../../firebase_service.dart';

class UserController extends GetxController {
  var showDialogFlag = false.obs;
  String username = 'Jhon';
  String display = 'view childs';
  String? childUpdateId;
  bool isReminder=false;
  String? reminderDate;
  String? reminderChildName;

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
    update();
  }

  updateEdits(String childName, String hospital, DateTime dob, String id) {
    childNameCtrl.text=childName;
    selectedHospital=hospital;
    dateOfBirth=dob;
    childUpdateId=id;
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

   if(childNameCtrl.text.isEmpty){
    customToast(message: 'Enter Child Name');
   }else if(selectedHospital!.isEmpty){
     customToast(message: 'Please Select Hospital');
   }else if(dateOfBirth==null){
     customToast(message: 'Please Select DOB');
   }else {
     bool result = await FirebaseService().isChildAdded(parentid!, childNameCtrl.text);
     if(result==true){
       customToast(message: '${childNameCtrl.text} is Already Added');
     }else {
       var child={
         'childname':childNameCtrl.text,
         'parentname': parentNameCtrl.text,
         'dateofbirth':dateOfBirth,
         'hospitalname':selectedHospital,
         'parentid':parentid
       };
       FirebaseService().submitChild(data: child);
       display = 'view childs';
       update();
     }
   }


  }

  updateChild() async {
    Child child=new Child(
      id: '123',
      parentName: '123',
      childName: childNameCtrl.text,
      hospitalname: selectedHospital!,
      dateOfBirth: dateOfBirth!,
      parentId: '123'
    );

    await FirebaseService().updateChildData(childUpdateId!,child);
    display = 'view childs';
    update();
  }


 List<Child> childslist=[];
  getAllChilds() async {
    childslist= await FirebaseService().getAllChildren('user');
    // print('child length ${childslist.length}');
    getAllChilds();
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
      'status': 'pending',
      'appointment_date': DateTime.now(),
    };
    print(data);
    await FirebaseService().bookAppointment(data: data);
  }

  //______________________all appointment
  List<ChildAppointment> allAppointmentsList=[];
  getAllAppointment() async {
    allAppointmentsList=await  FirebaseService().getAllAppointment('user');
    print('Appoint list : ${allAppointmentsList.length}');
    for(int i=0 ; i<allAppointmentsList.length; i++){
    isReminder=isRemaining5Hours(allAppointmentsList[i].appointmentDate.toString());
    if(isReminder==true && allAppointmentsList[i].status=='accepted'){
      reminderChildName=   allAppointmentsList[i].childName;
      DateTime? dateTime = DateTime.parse(allAppointmentsList[i].appointmentDate.toString());
      reminderDate = DateFormat('dd MMMM yyyy h:mm a').format(dateTime);
      showDialogFlag.value=true;
    }
    }
    update();
  }

  bool isRemaining5Hours(String inputTime) {

    DateTime dateTime = DateTime.parse(inputTime);
    DateTime now = DateTime.now();

    if (dateTime.isAfter(now)) {
      Duration remainingDuration = dateTime.difference(now);
      int remainingHours = remainingDuration.inHours;
      int remainingMinutes = remainingDuration.inMinutes % 60;
      print(remainingHours);
      if(remainingHours<=5){
        return true;
      }else
        {
          return false;
        }
    } else {
      return false;
    }

  }


  // Function to show the dialog
  void showAlertDialog() {
    List<String> splitList=reminderDate!.split(' ');
    String date= '${splitList[0]} ${splitList[1]} ${splitList[2]}';
    String time= '${splitList[3]} ${splitList[4]}';
    Get.dialog(
      CustomAlertDialog(childName: reminderChildName!, date: date, time: time),
      barrierDismissible: false, // Dialog cannot be dismissed by tapping outside
    );
  }
}
