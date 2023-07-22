
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
  List<ChildAppointment> allHospitalAppointmentsList = [];

  getAllAppointment() async {
    allHospitalAppointmentsList =
        await FirebaseService().getAllAppointment(hospitalName);
    print('Appoint list : ${allHospitalAppointmentsList.length}');
    update();
  }

  updateAppointMentSatus({childName, parentId, status, datetime}) async {

    if(status=='accepted' && datetime==null)
      {
        customToast(message: 'Please Select Date and Time ');
      }
    else{
      await FirebaseService()
          .updateAppointmentStatus(childName: childName, parentId: parentId, status: status, datetime: datetime);
      customToast(message: 'Appointment Successfully Done');
      await getAllAppointment();
      update();
    }

  }





  //____________________date picker
  DateTime? searchDate;



  //__________________________________UPDATE DATE OF BIRTH
  updateDateOfBirth({newDate}) {
    searchDate = newDate;
    update();
  }


  //________________________________SEARCH APPOINTMENT
  searchAppointment() async {
    allHospitalAppointmentsList = await FirebaseService().searchAppointment(
      searchDate!,hospitalName
    );
    print('List : ${allHospitalAppointmentsList.length}');
    update();
  }


}
