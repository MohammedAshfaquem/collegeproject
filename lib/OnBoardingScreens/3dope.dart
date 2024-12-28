import 'package:college_project/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class thirddope extends StatelessWidget {
  const thirddope({super.key});

  @override
  Widget build(BuildContext context) {
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
                  color: Color.fromARGB(248, 187, 151, 253),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        50.r,
                      ),
                      bottomRight: Radius.circular(50))),
            ),
            Positioned(
              bottom: 290.h,
              left: 135.w,
              child: Text("Welcome!",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w700)),
            ),
            Positioned(
              bottom: 250.h,
              left: 180.w,
              child: Text("Alone",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500)),
            ),
            Positioned(
              bottom: 220.h,
              left: 130.w,
              child: Text("We can do so little",
                  style: TextStyle(color: Colors.grey, fontSize: 18.sp)),
            ),
            Positioned(
              bottom: 190.h,
              left: 170.w,
              child: Text("Together",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500)),
            ),
            Positioned(
              bottom: 160.h,
              left: 130.w,
              child: Text("We can do so much",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 50.h,
            ),
            Positioned(
              top: 70.h,
              right: 50.w,
              child: Image.asset(
                "lib/images/findfoodlap.png",
                height: 300.h,
              ),
            ),
            SizedBox(
              width: 130.w,
            ),
            Positioned(
              bottom: 70.h,
              right: 30.w,
              child: GestureDetector(
                onTap: () async {
                  final pref = await SharedPreferences.getInstance();
                  await pref.setBool("ON_BOARDING", false);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => AuthGate()));
                },
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
