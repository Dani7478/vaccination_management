

import 'package:get/get.dart';
import 'package:vaccination_mangement/Widgets/custom_toast.dart';

import '../../Model/user_model.dart';
import '../../firebase_service.dart';

class AdminController extends GetxController {

  String hospitalname = 'Pending....';
  String display = 'view hospital';

  updateDisplay({currentDisplay}){
    display=currentDisplay;
    getHospitalList();
    print(display);
    update();
  }

  //_______________________on init
  @override
  void onInit() {
    getHospitalList();
    super.onInit();
  }

  List<User> hospitalsList=[];
  getHospitalList() async {
    hospitalsList= await FirebaseService().getAllHospital();
    update();
  }

  updateHosStatus({id,status}) async {
   await FirebaseService().updateHospitalStatus(userid:id,newStatus: status );
   await getHospitalList();
   update();
  }

  AddHospitalUpdate({name,status}) async {
    await FirebaseService().ADDupdateStatus(name: name,status: status);
    
    if(status==false){
        customToast(message: 'Hospital Removed');
    }else {
       customToast(message: 'Hospital Added');
    }
     await updateDisplay(currentDisplay: display);
  }

}