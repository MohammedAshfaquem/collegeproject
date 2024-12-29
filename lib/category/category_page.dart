import 'package:animate_do/animate_do.dart';
import 'package:college_project/Category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryDonate extends StatelessWidget {
  const CategoryDonate({super.key,  this.cheight = true});
final bool cheight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 830.h,
            color: Color(0xff247D7F),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height:cheight? 590.h:490,
                width: 550.w,
                color: Theme.of(context).colorScheme.secondary,
              )),
          Positioned(
            top: 80.h,
            left: 30.r,
            child: Text(
              "Select the category",
              style:GoogleFonts.poppins( color:  Theme.of(context).colorScheme.surface,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600)
            ),
          ),
          Positioned(
            top: 125.h,
            left: 30.r,
            child: Text(
             "Which category deos the food belongs to?",
              style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.surface, fontSize: 12),
            ),
          ),
          Positioned(
              top: 180.h,
              left: 10.w,
              child: Column(
                children: [
                  FadeInDown(
                    duration: Duration(milliseconds: 300),
                    delay: Duration(milliseconds: 100),
                    child: categorymodels(
                      category: 'Raw Food',
                      categoryno: 'Category 1',
                      image: 'lib/images/1stcategort.png',
                    ),
                  ),
                  FadeInDown(
                    duration: Duration(milliseconds: 400),
                    delay: Duration(milliseconds: 200),
                    child: categorymodels(
                      category: 'Cooked Food',
                      categoryno: 'Category 2',
                      image:
                          'lib/images/Green_Foods-transformed-removebg-preview.png',
                    ),
                  ),
                  FadeInDown(
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 300),
                    child: categorymodels(
                      category: 'Packed Food',
                      categoryno: 'Category 3',
                      image:
                          'lib/images/Food_Package-transformed-removebg-preview.png',
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
