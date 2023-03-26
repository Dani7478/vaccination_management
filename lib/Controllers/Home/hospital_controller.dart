import 'package:get/get.dart';
import 'package:vaccination_mangement/Widgets/custom_toast.dart';

import '../../Model/appointment_model.dart';
import '../../firebase_service.dart';

class HospitalController extends GetxController {
  String hospitalName = 'Hospital';
  String display = 'view appointment';

  //UPDATE DISPLAY.....................
  updateDisplay({currentView}) {
    display = currentView;
    print(display);
    getAllAppointment();
    update();
  }

  @override
  void onInit() {
    getName();
    super.onInit();
  }

  //Get hospital name......
   getName() async {
    hospitalName = await FirebaseService().getName();
    await getAllAppointment();
    update();
  }

  //______________________all appointment
  List<ChildAppointment> allHospitalAppointmentsList=[];
  getAllAppointment() async {
    allHospitalAppointmentsList=await  FirebaseService().getAllAppointment(hospitalName);
    print('Appoint list : ${allHospitalAppointmentsList.length}');
    update();
  }

  updateAppointMentSatus({childName, parentId})async {
 await FirebaseService().updateAppointmentStatus(childName:childName,parentId: parentId );
 customToast(message: 'Appointment Successfully Done');
  await getAllAppointment();
 update();
  }
}