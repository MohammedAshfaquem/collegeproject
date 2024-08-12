import 'package:college_project/Login/lofinpage.dart';
import 'package:college_project/Login/registerpage.dart';
import 'package:college_project/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class loginorsignup extends StatelessWidget {
 loginorsignup({super.key});
  bool islastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 830.h,
        child: Stack(
          children: [
            Image.asset('lib/images/logsign.png',height: 600.h,),
            Positioned(
                top: 0,
                child: Image.asset(
                  'lib/images/main_top.png',
                  height: 150,
                )),
            Positioned(
              bottom: 230.h,
              right: 31.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff247D7F),
                      borderRadius: BorderRadius.circular(27)),
                  height: 60.h,
                  width: 350.w,
                  child: Center(
                      child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            Positioned(
              bottom: 150.h,
              right: 31.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Registerpage(),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple[200],
                      borderRadius: BorderRadius.circular(27).r),
                  height: 60.h,
                  width: 350.w,
                  child: Center(
                      child: Text(
                    "SIGNUP",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Image.asset(
                  "lib/images/main_bottom.png",
                  height: 130.h,
                  color: Colors.green.shade200,
                )),
          ],
        ),
      ),
    );
  }
}
