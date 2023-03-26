import 'package:get/get.dart';
import 'package:vaccination_mangement/Controllers/Home/admin_controller.dart';
import 'package:vaccination_mangement/Controllers/Home/hospital_controller.dart';
import 'controllers.dart';



class AllBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(() => AuthenticationController());
    Get.lazyPut<loginController>(() => loginController());
    Get.lazyPut<RegistrationController>(() => RegistrationController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<AdminController>(() => AdminController());
     Get.lazyPut<HospitalController>(() => HospitalController());
  }

}