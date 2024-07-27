import 'package:college_project/Login/lofinpage.dart';
import 'package:college_project/Login/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Secoundscreen extends StatelessWidget {
  Secoundscreen({super.key});
  bool islastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 800.h,
        child: Stack(
          children: [
            Positioned(
              bottom: 420.h,
              right: 121.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => loginpage(),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff247D7F),
                      borderRadius: BorderRadius.circular(7)),
                  height: 50.h,
                  width: 150.w,
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
              bottom: 350.h,
              right: 121.w,
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
                      color: Colors.purple[100],
                      borderRadius: BorderRadius.circular(7)),
                  height: 50.h,
                  width: 150.w,
                  child: Center(
                      child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            Positioned(
              bottom: -50.h,
              left: -10.w,
              child: Image.asset(
                  "lib/images/sammy-line-bicycle-courier-delivering-food.png"),
            ),
          ],
        ),
      ),
    );
  }
}
