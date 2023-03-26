import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'View/authentication_view.dart';
class Storage {
  
  
   storeID({userid}) async {
     final prefs = await SharedPreferences.getInstance();
     await prefs.setString('userid', userid);
   }

   removeID() async {
     final prefs = await SharedPreferences.getInstance();
     await prefs.clear();
   }

   logout() async {
     final prefs = await SharedPreferences.getInstance();
     await prefs.clear();
     Get.offAll(AuthenticationView());
   }


}