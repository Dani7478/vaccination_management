import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccination_mangement/Controllers/controllers.dart';
import 'package:vaccination_mangement/View/Home/profile_view.dart';
import '../Constant/colors.dart';
import 'package:vaccination_mangement/storage.dart';

Widget userDrawer(context) {
  final UserController controller = Get.put(UserController());

  return SafeArea(
    child: Drawer(
      backgroundColor: primaryColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 100,
              color: creamColor,
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: primaryColor,
                      size: 50,
                    ),
                    radius: 30,
                    backgroundColor: creamColor,
                    foregroundColor: primaryColor,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  GetBuilder<UserController>(
                      init: UserController(),
                      builder: (controller) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.username}',
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'User Account',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        );
                      })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              color: creamColor,
              child: Row(
                children: [
                  Icon(
                    Icons.document_scanner_sharp,
                    color: primaryColor,
                    size: 50,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    'Appointments',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     controller.updateDisplay(currentView: 'book appointment');
            //     Navigator.pop(context);
            //   },
            //   child: Container(
            //     margin: EdgeInsets.all(5),
            //     padding: EdgeInsets.symmetric(horizontal: 10),
            //     height: 60,
            //     color: creamColor,
            //     child: Row(
            //       children: [
            //         Icon(
            //           Icons.preview_sharp,
            //           color: primaryColor,
            //           size: 30,
            //         ),
            //         SizedBox(
            //           width: 25,
            //         ),
            //         Text(
            //           'Book Appointment',
            //           style: GoogleFonts.lato(
            //             fontSize: 16,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                controller.updateDisplay(currentView: 'view appointment');
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                color: creamColor,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_calendar_sharp,
                      color: primaryColor,
                      size: 30,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'View Appointment',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                controller.updateDisplay(currentView: 'add appointment');
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                color: creamColor,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_calendar_sharp,
                      color: primaryColor,
                      size: 30,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Add Appointment',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              color: creamColor,
              child: Row(
                children: [
                  Icon(
                    Icons.child_care,
                    color: primaryColor,
                    size: 50,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    'Child Data',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                controller.updateDisplay(currentView: 'add child');
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                color: creamColor,
                child: Row(
                  children: [
                    Icon(
                      Icons.list_alt,
                      color: primaryColor,
                      size: 30,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Add Child',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                controller.updateDisplay(currentView: 'view childs');
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                color: creamColor,
                child: Row(
                  children: [
                    Icon(
                      Icons.more_sharp,
                      color: primaryColor,
                      size: 30,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'View Child Data',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: (){
                Get.to(MyProfilePage());
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                color: creamColor,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: primaryColor,
                      size: 30,
                    ),
                    SizedBox(width: 25,),
                    Text('Profile',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Storage().logout();
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                color: creamColor,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: primaryColor,
                      size: 30,
                    ),
                    SizedBox(width: 25,),
                    Text('Logout',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
