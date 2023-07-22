import 'package:firebase_core/firebase_core.dart';
import 'package:vaccination_mangement/Controllers/Home/profile_controller.dart';
import 'package:vaccination_mangement/View/screens.dart';
import 'package:vaccination_mangement/test.dart';
import 'Controllers/bindings.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaccination Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      initialBinding: AllBindings(),
      routes: {
        '/': (context) => SplashView(),
        '/AuthenticationView': (context) => AuthenticationView(),
      },
    );
  }
}



class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return const Placeholder();
  }
}