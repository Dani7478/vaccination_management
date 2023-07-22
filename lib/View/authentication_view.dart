import 'package:vaccination_mangement/Constant/colors.dart';
import '../Controllers/controllers.dart';
import '../Widgets/widgets.dart';
import 'screens.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: bgImage(
            context: context,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Expanded(
                    flex: 20,
                    child: topHeader(size),
                  ),
                  // Expanded(
                  //   flex: 20,
                  //   child: Column(
                  //     children: [
                  //       covid19Text(),
                  //     ],
                  //   ),
                  // ),
                  GetBuilder<AuthenticationController>(
                    init: AuthenticationController(),
                    builder: (controller) {
                      return Expanded(
                          flex: 80,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.08,
                                horizontal: size.height * 0.05),
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: InkWell(
                                            onTap: () {
                                              controller.updateAuth(
                                                  whichAuth: 'login');
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: controller.whichAuth ==
                                                          'login'
                                                      ? primaryColor
                                                      : whiteColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8.0))),
                                              child: Center(
                                                child: Text(
                                                  'LOGIN',
                                                  style: GoogleFonts.lato(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal),
                                                ),
                                              ),
                                            ),
                                          )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                controller.updateAuth(
                                                    whichAuth: 'register');
                                              },
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color:
                                                        controller.whichAuth ==
                                                                'register'
                                                            ? primaryColor
                                                            : whiteColor,
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    8.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8.0))),
                                                child: Center(
                                                  child: Text(
                                                    'REGISTER',
                                                    style: GoogleFonts.lato(
                                                        color: Colors.black87,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    controller.whichAuth == 'login' ?
                                    LoginPortion() :  controller.whichAuth == 'register' ? 
                                    RegisterPortion() : ChangePassword(),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}

//_______________________________________________LOGIN PORTION
class LoginPortion extends StatelessWidget {
  const LoginPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<loginController>(
      init: loginController(),
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customTextField(
                hintText: 'Enter Your Email',
                editingCtrl: controller.emailCtrl,
                obscur: false),
            customTextField(
                hintText: 'Enter Your Password',
                editingCtrl: controller.passwordCtrl,
                obscur: true),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){
                  Get.find<AuthenticationController>().updateAuth(
                                                  whichAuth: 'forgot');
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                    value: true,
                    activeColor: primaryColor,
                    checkColor: Colors.white,
                    onChanged: (value) {}),
                SizedBox(
                  width: 5,
                ),
                Text('Remember the Password'),
              ],
            ),
            customButton(
                btnText: 'Login',
                perform: () {
                  controller.submitData();
                })
          ],
        );
      },
    );
  }
}

//_______________________________________________LOGIN PORTION
class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<loginController>(
      init: loginController(),
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Chnage Password',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(height: 30,),

          
            customTextField(
                hintText: 'Enter Your Email',
                editingCtrl: controller.emailCtrl,
                obscur: false),
            customTextField(
                hintText: 'Enter Your Password',
                editingCtrl: controller.passwordCtrl,
                obscur: true),

                customTextField(
                hintText: 'Enter Confirm Your Password',
                editingCtrl: controller.confirmPasswordCtrl,
                obscur: true),
            
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                    value: true,
                    activeColor: primaryColor,
                    checkColor: Colors.white,
                    onChanged: (value) {}),
                SizedBox(
                  width: 5,
                ),
                Text('Remember the Password'),
              ],
            ),
            customButton(
                btnText: 'Save',
                perform: () {
                 controller.updatePasswordByEmail();
                })
          ],
        );
      },
    );
  }
}

//________________________________________________REGISTER PORTION
class RegisterPortion extends StatelessWidget {
  const RegisterPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
        init: RegistrationController(),
        builder: (con) {
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customTextField(
                      hintText: 'Full Name',
                      editingCtrl: con.fullNameCtrl,
                      obscur: false),
                  customTextField(
                      hintText: 'Email Address',
                      editingCtrl: con.emailCtrl,
                      obscur: false),
                  customTextField(
                      hintText: 'Phone Number',
                      editingCtrl: con.phoneCtrl,
                      obscur: false),
                  customTextField(
                      hintText: 'Password',
                      editingCtrl: con.passwordCtrl,
                      obscur: true),
                  customTextField(
                      hintText: 'Retype Password',
                      editingCtrl: con.confirmPasswordCtrl,
                      obscur: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'User',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Radio(
                          activeColor: primaryColor,
                          value: 'user',
                          groupValue: con.role,
                          onChanged: (value) {
                            con.updateRole(value.toString());
                          }),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Hospital',
                        style: GoogleFonts.lato(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Radio(
                          activeColor: primaryColor,
                          value: 'hospital',
                          groupValue: con.role,
                          onChanged: (value) {
                            con.updateRole(value.toString());
                          })
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: con.acceptConditions,
                          activeColor: primaryColor,
                          checkColor: Colors.white,
                          onChanged: (value) {
                            con.updateCondition();
                          }),
                      SizedBox(
                        width: 5,
                      ),
                      Text('I hereby Accept All Conditions'),
                    ],
                  ),
                  con.acceptConditions == true
                      ? customButton(
                          btnText: 'Register',
                          perform: () {
                            con.submitData();
                          })
                      : customButton(
                          btnText: 'Register',
                          perform: () {
                            customToast(message: 'Please Accept Conditions');
                          })
                ],
              ),
            ),
          );
        });
  }
}
