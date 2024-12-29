import 'package:college_project/OnBoardingScreens/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FirstScreen
 extends StatelessWidget {
  const FirstScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    final dopecontroller = Provider.of<OnBoardingController>(context, listen: false);
    return Scaffold(
      body: Container(
        height: 825.h,
        width: 415.w,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              height: 420.h,
              width: 420.w,
              decoration: BoxDecoration(
                  color: Color.fromARGB(251, 151, 253, 175),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        50,
                      ),
                      bottomRight: Radius.circular(50))),
            ),
            Positioned(
              bottom: 300.h,
              left: 75.w,
              child: Text("Making a Donation",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w700)),
            ),
            Positioned(
              bottom: 250.h,
              left: 140.w,
              child: Text("It is the ultimate",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500)),
            ),
            Positioned(
              bottom: 220.h,
              left: 90.w,
              child: Text("sign of soldarity .Action Speak",
                  style: TextStyle(color: Colors.grey, fontSize: 18.sp)),
            ),
            Positioned(
              bottom: 190.h,
              left: 130.w,
              child: Text("Louder Than Words",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 50.h,
            ),
            Positioned(
              top: 20.h,
              right: -110.w,
              child: Image.asset(
                "lib/images/Donatekid.png",
                height: 350.h,
              ),
            ),
            SizedBox(
              width: 130.w,
            ),
            Positioned(
              bottom: 70.h,
              right: 30.w,
              child: GestureDetector(
                onTap: () => dopecontroller.updatepage(1),
                child: Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      color: Color(0xff247D7F),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    LineAwesomeIcons.angle_right_solid,
                    size: 30.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }
}
