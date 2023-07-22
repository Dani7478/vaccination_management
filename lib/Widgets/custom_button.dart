import 'package:vaccination_mangement/View/screens.dart';
import '../Constant/colors.dart';

Widget customButton({btnText,perform}){
  return InkWell(
    onTap: (){
      perform();
    },
    child: Container(
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
        child: Text(
          btnText,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal
          ),
        ),
      ),
    ),
  );
}