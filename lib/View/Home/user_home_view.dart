import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccination_mangement/Model/appointment_model.dart';
import 'package:vaccination_mangement/Widgets/appointment_card.dart';
import '../../Controllers/Home/user_controller.dart';
import '../../Widgets/add_appointment_card.dart';
import '../../Widgets/child_card.dart';
import '../../Widgets/user_drawer.dart';
import '../../Widgets/widgets.dart';
import '../../Constant/constants.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var controller=Get.put(UserController());
    ever(controller.showDialogFlag, (value) {
      if (value == true) {
        controller.showAlertDialog();
      }
    });

    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return WillPopScope(
      onWillPop: () async => await false,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: userDrawer(context),
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
              GetBuilder<UserController>(
                  init: UserController(),
                  builder: (con) {
                    if (con.display == 'add child') {
                      return AddChild();
                    } else if (con.display == 'view childs') {
                      return ViewChilds();
                    } else if (con.display == 'edit childs') {
                      return EditChild();
                    } else if (con.display == 'view appointment') {
                      return ViewAppointments();
                    }else if (con.display == 'add appointment') {
                      return AddAppointments();
                    }
                    else {
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

//________________________ADD CHILD
class AddChild extends StatelessWidget {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();

  const AddChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find<UserController>();
    return Expanded(
      flex: 80,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(1),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  color: primaryColor,
                  child: customTextField(
                      hintText: 'Enter Child Name',
                      editingCtrl: controller.childNameCtrl,
                      obscur: false),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  color: primaryColor,
                  child: customTextField(
                      hintText: 'Enter Parent Name',
                      editingCtrl: controller.parentNameCtrl,
                      obscur: false),
                ),
                GetBuilder<UserController>(builder: (con) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: primaryColor,
                    child: InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null &&
                            picked != controller.dateOfBirth) {
                          controller.updateDateOfBirth(newDate: picked);
                        }
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(color: Colors.white60),
                        child: Center(
                            child: Text(
                          con.dateOfBirth == null
                              ? 'Select Date of Birth'
                              : '${con.dateOfBirth?.day} : ${con.dateOfBirth?.month} : ${con.dateOfBirth?.year}',
                          style: GoogleFonts.lato(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )),
                      ),
                    ),
                  );
                }),
                GetBuilder<UserController>(builder: (con) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: primaryColor,
                    child: InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null &&
                            picked != controller.dateOfBirth) {
                          controller.updateDateOfBirth(newDate: picked);
                        }
                      },
                      child: GetBuilder<UserController>(
                        init: UserController(),
                        builder: (con) {
                          return Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(color: Colors.white60),
                            child: Center(
                              child: DropdownButton<String>(
                                hint: Text('Select Nearest Hospital'),
                                value: con.selectedHospital,
                                onChanged: (value) {
                                  con.updateHospital(
                                      newHospital: value.toString());
                                },
                                items: con.hospitalList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
                InkWell(
                  onTap: () async {
                    if (controller.childNameCtrl.text.isEmpty) {
                      customToast(message: 'Please Enter Child name');
                    } else if (controller.selectedHospital ==
                        'Select Nearest Hospital') {
                      customToast(message: 'Please Select Hospital');
                    } else {
                      await controller.submitChild();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    height: 60,
                    color: primaryColor,
                    width: context.width,
                    child: Center(
                      child: Text(
                        'Submit Child',
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//________________________ADD CHILD
class EditChild extends StatelessWidget {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();

  EditChild({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find<UserController>();

    return Expanded(
      flex: 80,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(1),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  color: primaryColor,
                  child: customTextField(
                      hintText: 'Enter Child Name',
                      editingCtrl: controller.childNameCtrl,
                      obscur: false),
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  color: primaryColor,
                  child: customTextField(
                      hintText: 'Enter Parent Name',
                      editingCtrl: controller.parentNameCtrl,
                      obscur: false),
                ),
                GetBuilder<UserController>(builder: (con) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: primaryColor,
                    child: InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null &&
                            picked != controller.dateOfBirth) {
                          controller.updateDateOfBirth(newDate: picked);
                        }
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(color: Colors.white60),
                        child: Center(
                            child: Text(
                          con.dateOfBirth == null
                              ? 'Select Date of Birth'
                              : '${con.dateOfBirth?.day} : ${con.dateOfBirth?.month} : ${con.dateOfBirth?.year}',
                          style: GoogleFonts.lato(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )),
                      ),
                    ),
                  );
                }),
                GetBuilder<UserController>(builder: (con) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: primaryColor,
                    child: InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null &&
                            picked != controller.dateOfBirth) {
                          controller.updateDateOfBirth(newDate: picked);
                        }
                      },
                      child: GetBuilder<UserController>(
                        init: UserController(),
                        builder: (con) {
                          return Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(color: Colors.white60),
                            child: Center(
                              child: DropdownButton<String>(
                                hint: Text('Select Nearest Hospital'),
                                value: con.selectedHospital,
                                onChanged: (value) {
                                  con.updateHospital(
                                      newHospital: value.toString());
                                },
                                items: con.hospitalList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
                InkWell(
                  onTap: () async {
                    if (controller.childNameCtrl.text.isEmpty) {
                      customToast(message: 'Please Enter Child name');
                    } else if (controller.selectedHospital ==
                        'Select Nearest Hospital') {
                      customToast(message: 'Please Select Hospital');
                    } else {
                     await  controller.updateChild();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    height: 60,
                    color: primaryColor,
                    width: context.width,
                    child: Center(
                      child: Text(
                        'Save Changes',
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//_______________________View Child Data
class ViewChilds extends StatelessWidget {
  const ViewChilds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 80,
        child: GetBuilder<UserController>(
          init: UserController(),
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
        ));
  }
}


//_______________________View Child Data
class AddAppointments extends StatelessWidget {
  const AddAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 80,
        child: GetBuilder<UserController>(
          init: UserController(),
          builder: (con) {
            return ListView.builder(
                itemCount: con.childslist.length,
                itemBuilder: (context, index) {
                  return AddAppointmentCard(
                    childName: con.childslist[index].childName,
                    parentName: con.childslist[index].parentName,
                    hospital: con.childslist[index].hospitalname,
                    id: con.childslist[index].id,
                    dob: con.childslist[index].dateOfBirth,
                  );
                });
          },
        ));
  }
}

//______________________View Appointments
class ViewAppointments extends StatelessWidget {
  const ViewAppointments({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 80,
        child: GetBuilder<UserController>(
          init: UserController(),
          builder: (con) {
            return ListView.builder(
                itemCount: con.allAppointmentsList.length,
                itemBuilder: (context, index) {
                  ChildAppointment appoint = con.allAppointmentsList[index];
                  return AppointmentCard(
                    childName: appoint.childName!,
                    date:
                        appoint.appointmentDate.toString(),
                    hospitalName: appoint.hospitalName!,
                    status: appoint.status!,
                    view: 'user',
                    parentId: appoint.parentId!,
                  );
                });
          },
        ));
  }
}
