import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class firstscreen extends StatelessWidget {
  const firstscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: -70.h,
            left: 60.w,
            child: Image.asset(
              "lib/images/sammy-line-cook-preparing-ingredients-for-a-recipe.png",
              height: 400.h,
            ),
          ),
          Positioned(
              top: 270.h,
              left: 50.w,
              child: Container(
                  height: 80.h,
                  child: Text(
                    "MEALIO",
                    style: TextStyle(
                        color: Color(0xff247D7F),
                        fontSize: 65.sp,
                        fontWeight: FontWeight.w900),
                  ))),
          Positioned(
              top: 350.h,
              left: 50.w,
              child: Image.asset(
                "lib/images/render (1).png",
                height: 15.h,
                color: Color(0xff247D7F),
              ))
        ],
      ),
    );
  }
}
