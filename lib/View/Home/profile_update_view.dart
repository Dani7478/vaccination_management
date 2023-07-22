// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccination_mangement/Controllers/Home/profile_controller.dart';
import '../../Constant/colors.dart';

class ProfileUpdateView extends StatelessWidget {
  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('Page Design'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/profile-img.png'),
              ),
              SizedBox(height: 16.0),
              Text(
                controller.email!,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              ),

              SizedBox(height: 100.0),
              TextFormField(
                controller: controller.nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: controller.phoneCtrl,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: controller.passwordCtrl,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: controller.confirmCtrl,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30.0),
              MaterialButton(
                minWidth: 200,
                height: 50,
                color: primaryColor,
                onPressed: () {
                  controller.updateUser();
                },
                child: GetBuilder<ProfileController>(
                    builder: (controller) {
                      return controller.isLoading == false ? Text(
                        'Update', style: TextStyle(color: Colors.white)
                      ) : SizedBox(
                        height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white,));
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
