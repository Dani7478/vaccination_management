import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccination_mangement/Controllers/Home/profile_controller.dart';

import '../../Constant/colors.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   var controller= Get.put(ProfileController());
   controller.getProfileData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text('Profile Page'),
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return controller.isLoading==false ?  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.0),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/profile-img.png'),
              ),
              SizedBox(height: 16.0),
              Text(
                controller.email!,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Divider(),
              SizedBox(height: 80.0),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  controller.name!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(
                  controller.phone!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  ),
                )
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text(
                  controller.password!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  ),
                )
              ),
              SizedBox(
                height: 50,
              ),
              MaterialButton(
                color: primaryColor,
                minWidth: 200,
                height: 50,
                onPressed: () {
                  controller.moveNext();
                  // Add your edit logic here
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
            ],
          ) :Center(child: SizedBox(
            height:40,
            width: 40,
            child: CircularProgressIndicator()));
        }
      ),
    );
  }
}
