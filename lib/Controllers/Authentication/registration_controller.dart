import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_mangement/firebase_service.dart';

import '../../Widgets/widgets.dart';
import '../authentication_controller.dart';

class RegistrationController extends GetxController {
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  String role = 'user';
  bool acceptConditions = false;

  updateRole(String role) {
    this.role = role;
    update();
  }

  updateCondition() {
    acceptConditions = !acceptConditions;
    update();
  }

  submitData() async {
    if (fullNameCtrl.text.isEmpty) {
      customToast(message: 'Please Enter Full Name');
    } else if (emailCtrl.text.isEmpty) {
      customToast(message: 'Please Enter Email');
    } else if (phoneCtrl.text.isEmpty) {
      customToast(message: 'Please Enter Phone Number');
    } else if (passwordCtrl.text.isEmpty) {
      customToast(message: 'Please Password');
    } else if (passwordCtrl.text != passwordCtrl.text) {
      customToast(message: 'Password And Confirm Password Should Same');
    } else {
      if (passwordCtrl.text != confirmPasswordCtrl.text) {
        customToast(message: 'Password are not same');
      } else {
        var newUser = {
          //json form // flutter : Map<String,dynaic>
          'name': fullNameCtrl.text,
          'email': emailCtrl.text,
          'phone': phoneCtrl.text,
          'password': passwordCtrl.text,
          'role': role,
          'status': 'pending',
          'allow': false
        };
        await FirebaseService().registerUser(data: newUser);
        Get.put(AuthenticationController());
        Get.find<AuthenticationController>().updateAuth(whichAuth: 'login');
      }
    }
  }

 
}
