import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccination_mangement/Controllers/Home/hospital_controller.dart';
import 'package:vaccination_mangement/Model/appointment_model.dart';
import 'package:vaccination_mangement/Model/user_model.dart';
import 'package:vaccination_mangement/Widgets/appointment_card.dart';
import 'package:vaccination_mangement/Widgets/hospital_drawer.dart';
import '../../Controllers/Home/user_controller.dart';
import '../../Widgets/admin_drawer.dart';
import '../../Widgets/child_card.dart';
import '../../Widgets/user_drawer.dart';
import '../../Widgets/widgets.dart';
import '../../Constant/constants.dart';

class HospitalHomeView extends StatelessWidget {
  const HospitalHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return WillPopScope(
      onWillPop: () async => await false,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: hospitalDrawer(context),
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 20,
                child: Row(
                  children: [
                    Expanded(
                      flex: 15,
                      child: InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Icon(
                          Icons.menu,
                          size: size.width * 0.15,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 85,
                      child: topHeader(size),
                    ),
                  ],
                ),
              ),
              GetBuilder<HospitalController>(
                  init: HospitalController(),
                  builder: (con) {
                  if(con.display=='view appointment'){
                    return ViewAppointments();
                  }else {
                     return Expanded(
                        flex: 80,
                        child: Placeholder(),
                      );
                  }
                     
                   
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

//______________________View Appointments
class ViewAppointments extends StatelessWidget {
  const ViewAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 80,
        child: GetBuilder<HospitalController>(
          init: HospitalController(),
          builder: (con) {
            return ListView.builder(
                itemCount: con.allHospitalAppointmentsList.length,
                itemBuilder: (context, index) {
                  ChildAppointment appoint= con.allHospitalAppointmentsList[index];
                  return AppointmentCard(
                    childName: appoint.childName!,
                    date:'${appoint.bookDate?.day}:${appoint.bookDate?.month}:${appoint.bookDate?.year}',
                    hospitalName: appoint.hospitalName!,
                    status: appoint.status!,
                    view: 'hospital',
                    parentId: appoint.parentId!,
                  );
                });
          },
        ));
  }
}