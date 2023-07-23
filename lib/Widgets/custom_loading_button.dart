import 'package:vaccination_mangement/View/screens.dart';
import '../Constant/colors.dart';

Widget customLoadingButton(){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    height: 60,
    // width: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          primaryLightColor,
          Color(0xFFf27f18),
        ],
      ),
    ),

    child: Center(
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 5,
        ),
      ),
    ),
  );
}