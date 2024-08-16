import 'package:college_project/Dopescreens/3dope.dart';
import 'package:college_project/Dopescreens/dopcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class secounddope extends StatelessWidget {
  const secounddope({super.key});

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
                    "Explore",
                    style: TextStyle(
                        color: Color(0xff247D7F),
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                      child: Text("Together",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500))),
                  Text("We All Are create. ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18.sp)),
                  Text("A Hunger Fee world.",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 50.h,
                  ),
                  Image.asset(
                    "lib/images/greendop3.png",
                    height: 300.h,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      TextButton(
                          onPressed: () {
                            dopecontroller.updatepage(3);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.grey.shade200)),
                          child: Text(
                            "Skip",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                      SizedBox(
                        width: 130,
                      ),
                      GestureDetector(
                        onTap: () => dopecontroller.updatepage(2),
                        child: Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                              color: Color(0xff247D7F),
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.arrow_right_alt_rounded,
                            size: 40.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
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
