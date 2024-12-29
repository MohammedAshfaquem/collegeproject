import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DonateCard extends StatelessWidget {
  const DonateCard(
      {super.key,
      required this.text,
      required this.imageurl,
      required this.onTap});
  final String text;
  final String imageurl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
            color: Color(0xff247D7F), borderRadius: BorderRadius.circular(20)),
        width: 180.w,
        child: Column(
          children: [
            Image.asset(
              imageurl,
              height: 150.h,
            ),
            Text(text,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
