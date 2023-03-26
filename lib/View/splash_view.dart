import 'dart:async';
import '../Constant/constants.dart';
import 'screens.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    Timer(
         const Duration(seconds: 5),
        ()=> Get.to(const AuthenticationView())
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: context.height * 0.2,
            bottom: context.height * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                child: Image.asset(mainLogo),
              ),
              Text(
                '$projectName \n for Children',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: splashColor,
                  strokeWidth: 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
