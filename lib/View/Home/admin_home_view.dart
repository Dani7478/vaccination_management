import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccination_mangement/Model/user_model.dart';
import '../../Controllers/Home/admin_controller.dart';
import '../../Widgets/add_hospital_card.dart';
import '../../Widgets/admin_drawer.dart';
import '../../Widgets/hospital_card.dart';
import '../../Widgets/widgets.dart';
import '../../Constant/constants.dart';


class AdminHomeView extends StatelessWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return WillPopScope(
      onWillPop:() async =>await false ,
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
                      flex:15,
                        child: InkWell(
                          onTap: (){
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: Icon(
                              Icons.menu,
                            size: size.width*0.15,
                            color: primaryColor,
                          ),
                        ),
                    ),
                    Expanded(
                     flex: 85,
                      child:topHeader(size),
                    ),

                  ],
                ),
              ),
             GetBuilder<AdminController>(
              init: AdminController(),
              builder: (con){
               return  Expanded(
                flex: 80,
                  child:con.display=='view hospital' ? 
                  AllHospitals() : 
                  con.display=='add hospital'? 
                   AddHospital(): Placeholder(),
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
    return GetBuilder(
      init: AdminController(),
        builder: (con){
        return  ListView.builder(
              itemCount: con.hospitalsList.length,
              itemBuilder: (context,index){
                User user=con.hospitalsList[index];
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
    return GetBuilder(
      init: AdminController(),
        builder: (con){
        return  ListView.builder(
              itemCount: con.hospitalsList.length,
              itemBuilder: (context,index){
              User user=con.hospitalsList[index];
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
