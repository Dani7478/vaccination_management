
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  String whichAuth='login';

  updateAuth({whichAuth}){
    this.whichAuth=whichAuth;
    update();
  }
}