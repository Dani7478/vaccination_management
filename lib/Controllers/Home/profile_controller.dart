import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccination_mangement/View/Home/profile_update_view.dart';
import 'package:vaccination_mangement/View/Home/user_home_view.dart';
import 'package:vaccination_mangement/View/screens.dart';
import 'package:vaccination_mangement/Widgets/custom_toast.dart';

class ProfileController extends GetxController {
  String? email;
  String? name;
  String? phone;
  String? password;
  bool isLoading = true;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmCtrl = TextEditingController();

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }

  moveNext() {
    nameCtrl.text = name!;
    phoneCtrl.text = phone!;
    passwordCtrl.text = password!;
    confirmCtrl.text = password!;

    Get.to(ProfileUpdateView());
  }

  getProfileData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? userId = pref.getString('userid');

      final DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();
      final Map<String, dynamic>? data =
          snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        // final Map<String, dynamic> data = snapshot.data();
        email = data['email'] ?? '';
        name = data['name'] ?? '';
        password = data['password'] ?? '';
        phone = data['phone'] ?? '';
        isLoading = false;
        update();
      }
    } catch (error) {
      isLoading = false;
      update();
      print('ERRO: ${error.toString()}');
    }
    isLoading = false;
    update();
  }


   Future<void> updateUser() async {
     SharedPreferences pref = await SharedPreferences.getInstance();
      String? userId = pref.getString('userid');
   if(nameCtrl.text.isEmpty){
    customToast(message: 'Name Required');
   }else if(phoneCtrl.text.isEmpty){
    customToast(message: 'Name Required');
   }else if(passwordCtrl.text.isEmpty){
    customToast(message: 'Password Required');
   }else if(passwordCtrl.text!=confirmCtrl.text){
    customToast(message: 'Password Must be same');
   }else {
    try {
      isLoading=true;
      update();
      final DocumentReference docRef =
          FirebaseFirestore.instance.collection('user').doc(userId);

          final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('child')
          .where('parentid', isEqualTo: userId)
          .get();

          final QuerySnapshot snapshot2 = await FirebaseFirestore.instance
          .collection('appointment')
          .where('parentId', isEqualTo: userId)
          .get();


           for (final DocumentSnapshot doc in snapshot.docs) {
        final DocumentReference docRef =
            FirebaseFirestore.instance.collection('child').doc(doc.id);

        await docRef.update({
          'parentname': nameCtrl.text,
        });

        print('Parent name updated for document ID: ${doc.id}');
      }

         for (final DocumentSnapshot doc in snapshot2.docs) {
        final DocumentReference docRef =
            FirebaseFirestore.instance.collection('appointment').doc(doc.id);

        await docRef.update({
          'parentName': nameCtrl.text,
        });

        print('Parent name updated for document ID: ${doc.id}');
      }



      await docRef.update({
        'name': nameCtrl.text,
        'phone': phoneCtrl.text,
        'password': passwordCtrl.text
      });

         customToast(message: 'Profile Updated Successfully');
         Get.to(UserHomeView());
      print('User data updated successfully!');
    } catch (e) {
      print('Error updating user data: $e');
      isLoading=false;
      update();
    }
    isLoading=false;
    update();
   }
  }
}
