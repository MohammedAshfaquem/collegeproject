import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Secound extends StatelessWidget {
  const Secound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        
        height: 785,
        width: 395,
         color: Colors.white,
        child: Stack(
          children: [
            Image.asset(
              'lib/images/main_top.png',
              color: Colors.purple.shade100,

              height: 150,
            ),
             Positioned(
                  left: 70,
                  top: 100,
                  child: Image.asset(
                    "lib/images/epidemiology.png",
                    height: 250.h,
                  ),
                ),
            Positioned(
              bottom: 200,
              left: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  Text(
                    "TOGETHER \nWE'LL CREATE ",
                    style: TextStyle(color:Colors.green, fontSize: 35.sp),
                  ),
                  Text("   A HUNGER FREE \n   WORLD",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset('lib/images/login_bottom.png',
              color: Colors.green.shade100,
              height: 150,))
          ],
        ),
      ),
    );
  }
}
