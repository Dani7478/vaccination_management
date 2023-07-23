import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_mangement/firebase_service.dart';
import '../../View/Home/admin_home_view.dart';
import '../../Widgets/widgets.dart';
import '../authentication_controller.dart';

class loginController extends GetxController { //getx state management 
  TextEditingController emailCtrl=TextEditingController();
  TextEditingController passwordCtrl=TextEditingController();
  TextEditingController confirmPasswordCtrl=TextEditingController();
  bool isLoading=false;


  changePassword(){
    if(emailCtrl.text.isEmpty){
      customToast(message: 'Please Enter Email');
    }
  }


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
      isLoading=true;
      update();
      try{
        await FirebaseService().loginUser(email: emailCtrl.text,password: passwordCtrl.text);
        isLoading=false;
        update();
      }catch(error){
        isLoading=false;
        update();
      }

    }
  }

   Future<void> updatePasswordByEmail() async {
    if (emailCtrl.text.isEmpty) {
      customToast(message: 'Enter Email Address');
    } else if (passwordCtrl.text.isEmpty) {
      customToast(message: 'Enter Password');
    } else if (confirmPasswordCtrl.text.isEmpty) {
      customToast(message: 'Enter Confirm Password');
    }else if(passwordCtrl.text!=confirmPasswordCtrl.text){
      customToast(message: 'Password Must be Same');
    }else {
      try {
      final userQuery = FirebaseFirestore.instance
          .collection('user')
          .where('email', isEqualTo: emailCtrl.text);
      final userSnapshot = await userQuery.get();

      if (userSnapshot.docs.isEmpty) {
        customToast(message: 'No user found with the provided email.');
        return;
      }

      final userDoc = userSnapshot.docs.first;
      final userRef =
          FirebaseFirestore.instance.collection('user').doc(userDoc.id);

      await userRef.update({'password': passwordCtrl.text});

      customToast(message: 'Password updated successfully.');
      Get.find<AuthenticationController>().updateAuth(whichAuth: 'login');
    } catch (e) {
      customToast(message: 'Error updating password: $e');
    }
    }
    
  }
}
