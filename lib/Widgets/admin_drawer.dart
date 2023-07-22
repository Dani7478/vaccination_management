import 'package:vaccination_mangement/storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccination_mangement/Controllers/Home/admin_controller.dart';
import '../Constant/colors.dart';
import 'package:get/get.dart';

Widget adminDrawer(context){
  AdminController controller=  Get.put(AdminController());
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
                  SizedBox(width: 25,),
                  Text('Mr.Sikandar (Admin)',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  )
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
                    Icons.local_hospital_outlined,
                    color: primaryColor,
                    size: 50,
                  ),
                  SizedBox(width: 25,),
                  Text('Hospital',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){
                controller.updateDisplay(currentDisplay: 'view hospital');
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
                      Icons.preview_sharp,
                      color: primaryColor,
                      size: 30,
                    ),
                    SizedBox(width: 25,),
                    Text('All Hospital',
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
                controller.updateDisplay(currentDisplay: 'add hospital');
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
                      Icons.preview_sharp,
                      color: primaryColor,
                      size: 30,
                    ),
                    SizedBox(width: 25,),
                    Text('Add Hospital',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
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
                 SizedBox(width: 25,),
                 Text('Appointments',
                   style: GoogleFonts.lato(
                     fontSize: 18,
                     fontWeight: FontWeight.w800,
                   ),
                 )
               ],
             ),
           ),
            InkWell(
              onTap: (){
                controller.updateDisplay(currentDisplay: 'all appointments');
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
                      Icons.preview_sharp,
                      color: primaryColor,
                      size: 30,
                    ),
                    SizedBox(width: 25,),
                    Text('View All',
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
                controller.updateDisplay(currentDisplay: 'export');
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
                      Icons.save_sharp,
                      color: primaryColor,
                      size: 30,
                    ),
                    SizedBox(width: 25,),
                    Text('Export/Save',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
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
                  SizedBox(width: 25,),
                  Text('Child Data',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){
                controller.updateDisplay(currentDisplay: 'all childs');
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
                    SizedBox(width: 25,),
                    Text('View Child Data',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // InkWell(
            //   onTap: (){
            //    controller.updateDisplay(currentDisplay: 'more');
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
            //           Icons.more_sharp,
            //           color: primaryColor,
            //           size: 30,
            //         ),
            //         SizedBox(width: 25,),
            //         Text('More',
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