import 'package:college_project/Category/categorydetailsapge.dart';
import 'package:college_project/Donatepage/donate_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class categorymodels extends StatelessWidget {
  const categorymodels({
    super.key,
    required this.category,
    required this.categoryno,
    required this.image,
  });
  final String category;
  final String categoryno;
  final String image;

  @override
  Widget build(BuildContext context) {
    final imagcontroller = Provider.of<Donate>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryDetails (
              image:image ,
                  category: category,
                  function: () => imagcontroller.clearImageCache(),
                )));
      },
      child: Container(
        width: 350.w,
        height: 160.h,
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10).w,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(25).r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 35.h,),
                Text(categoryno,
                    style: GoogleFonts.poppins(
                        color: Color(0xff247D7F),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500)),
                        SizedBox(height: 20.h,),
                Text(
                  category,
                  style: GoogleFonts.poppins(
                      color: Color(0xff247D7F),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height:0.h,
                ),
              ],
            ),
            SizedBox(
              height: 250.h,
              child: Image.asset(
                image,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
