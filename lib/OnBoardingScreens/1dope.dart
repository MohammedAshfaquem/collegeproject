import 'package:college_project/OnBoardingScreens/dopcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class firstdope extends StatelessWidget {
  const firstdope({super.key});

  @override
  Widget build(BuildContext context) {
    final dopecontroller = Provider.of<DopeController>(context, listen: false);
    return Scaffold(
      body: Container(
        height: 825.h,
        width: 415.w,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                  color: Color.fromARGB(251, 151, 253, 175),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        50,
                      ),
                      bottomRight: Radius.circular(50))),
            ),
            Positioned(
              bottom: 280,
              left: 75,
              child: Text("Making a Donation",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w700)),
            ),
            Positioned(
              bottom: 240,
              left: 130,
              child: Text("It is the ultimate",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500)),
            ),
            Positioned(
              bottom: 210,
              left:90,
              child: Text("sign of soldarity .Action Speak",
                  style: TextStyle(color: Colors.grey, fontSize: 18.sp)),
            ),
            Positioned(
              bottom: 180,
              left: 120,
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
              top: 20,
              right: -100,
              child: Image.asset(
                "lib/images/Donatekid.png",
                height: 350.h,
              ),
            ),

            // TextButton(
            //     onPressed: () {
            //       dopecontroller.updatepage(3);
            //     },
            //     style: ButtonStyle(
            //         backgroundColor:
            //             WidgetStatePropertyAll(Colors.grey.shade200)),
            //     child: Text(
            //       "Skip",
            //       style: TextStyle(
            //           fontSize: 16, fontWeight: FontWeight.w600),
            //     )),
            SizedBox(
              width: 130,
            ),
            Positioned(
              bottom: 70,
              right: 30,
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
