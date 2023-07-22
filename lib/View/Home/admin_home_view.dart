import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccination_mangement/Model/user_model.dart';
import '../../Controllers/Home/admin_controller.dart';
import '../../Model/appointment_model.dart';
import '../../Widgets/add_hospital_card.dart';
import '../../Widgets/admin_drawer.dart';
import '../../Widgets/appointment_card.dart';
import '../../Widgets/child_card.dart';
import '../../Widgets/hospital_card.dart';
import '../../Widgets/widgets.dart';
import '../../Constant/constants.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return WillPopScope(
      onWillPop: () async => await false,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: adminDrawer(context),
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
              GetBuilder<AdminController>(
                  init: AdminController(),
                  builder: (con) {
                    return Expanded(
                      flex: 80,
                      child: con.display == 'view hospital'
                          ? AllHospitals()
                          : con.display == 'add hospital'
                              ? AddHospital()
                              : con.display == 'all childs'
                                  ? ViewChilds()
                                  : con.display == 'all appointments'
                                      ? ViewAppointments()
                                      : con.display == 'export'
                                          ? SaveAppointments()
                                          : Placeholder(),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

//_____________view all hospital widget

class AllHospitals extends StatelessWidget {
  const AllHospitals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
        init: AdminController(),
        builder: (con) {
          return ListView.builder(
              itemCount: con.hospitalsList.length,
              itemBuilder: (context, index) {
                User user = con.hospitalsList[index];
                return HospitalCard(
                  hospitalid: user.userid!,
                  status: user.status!,
                  contactNo: user.phone!,
                  hospitalName: user.name!,
                  image: 'https://cdn-icons-png.flaticon.com/512/33/33777.png',
                );
              });
        });
  }
}

//_____________view all hospital widget

class AddHospital extends StatelessWidget {
  const AddHospital({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
        init: AdminController(),
        builder: (con) {
          return ListView.builder(
              itemCount: con.hospitalsList.length,
              itemBuilder: (context, index) {
                User user = con.hospitalsList[index];
                return AddHospitalCard(
                  hospitalName: user.name!,
                  contactNo: user.phone!,
                  allow: user.allow!,
                  status: user.status!,
                );
              });
        });
  }
}

//_______________________View Child Data
class ViewChilds extends StatelessWidget {
  const ViewChilds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
      init: AdminController(),
      builder: (con) {
        return ListView.builder(
            itemCount: con.childslist.length,
            itemBuilder: (context, index) {
              return ChildCard(
                childName: con.childslist[index].childName,
                parentName: con.childslist[index].parentName,
                hospital: con.childslist[index].hospitalname,
                id: con.childslist[index].id,
                dob: con.childslist[index].dateOfBirth,
              );
            });
      },
    );
  }
}

//______________________View Appointments
class ViewAppointments extends StatelessWidget {
  const ViewAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
      init: AdminController(),
      builder: (con) {
        return ListView.builder(
            itemCount: con.allAppointmentsList.length,
            itemBuilder: (context, index) {
              ChildAppointment appoint = con.allAppointmentsList[index];
              return AppointmentCard(
                childName: appoint.childName!,
                date: appoint.appointmentDate.toString(),
                hospitalName: appoint.hospitalName!,
                status: appoint.status!,
                view: 'user',
                parentId: appoint.parentId!,
              );
            });
      },
    );
  }
}

//____________________Save Export
class SaveAppointments extends StatelessWidget {
  const SaveAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
      init: AdminController(),
      builder: (con) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Appointments',
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),

            Text(
              '${con.totalAppointment}',
              style: TextStyle(
                  fontSize: 35,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30,),

            MaterialButton(
                color: primaryColor,
                minWidth: 200,
                height: 50,
                child: Text(
                  'Save Appointments',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  con.saveAppointmentsAsPdf(context);
                })
          ],
        );
      },
    );
  }
}
