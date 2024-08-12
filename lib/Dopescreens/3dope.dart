import 'package:college_project/Login/loginorsignup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

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
            Image.asset(
              'lib/images/main_top.png',
              color: Color.fromARGB(255, 93, 154, 155),
              height: 150.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome!",
                    style: TextStyle(
                        color: Color(0xff247D7F),
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                      child: Text("Alone",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500))),
                  Text("We can do so little ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18.sp)),
                  Center(
                      child: Text("Together",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500))),
                  Text("We can do so much",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18.sp,
                      )),
                  SizedBox(
                    height: 50.h,
                  ),
                  Image.asset(
                    "lib/images/celebration.png",
                    height: 250.h,
                    width: 400.w,
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                               Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => loginorsignup(),
                                ));
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Colors.grey.shade200)),
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w600),
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => loginorsignup(),
                                ));
                          },
                          child: Container(
                            height: 65.h,
                            width: 190.w,
                            decoration: BoxDecoration(
                                color: Color(0xff247D7F),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Text(
                              "Get Started",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
