import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_mangement/firebase_service.dart';
import 'package:vaccination_mangement/storage.dart';
import '../../View/Home/admin_home_view.dart';
import '../../Widgets/widgets.dart';

class loginController extends GetxController { //getx state management 
  TextEditingController emailCtrl=TextEditingController();
  TextEditingController passwordCtrl=TextEditingController();

  submitData() async {
    if(emailCtrl.text.isEmpty){
      customToast(message: 'Please Enter Email');
    }
    else if(passwordCtrl.text.isEmpty){
      customToast(message: 'Please Enter Password');
    }
    else if(passwordCtrl.text=='admin' && emailCtrl.text=='admin') {

      customToast(message: 'Welcome in Vaccination Management}');
      Get.to(AdminHomeView());
    }
    else {
     await FirebaseService().loginUser(email: emailCtrl.text,password: passwordCtrl.text);
      // customToast(message: 'Welcome in Vaccination Management');
    }
  }
}
