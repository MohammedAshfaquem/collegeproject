import 'package:college_project/Donatepage/donate_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class Detailspage extends StatefulWidget {
  var foodname;
  var itemdes;
  var user;
  var cntctno;
  var course;
  var imageurl;
  var option;
  var lname;
  var time;
  Detailspage(
      {super.key,
      required this.lname,
      this.option,
      this.foodname,
      this.itemdes,
      this.user,
      this.cntctno,
      this.course,
      this.imageurl,
      required this.time});

  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  bool _isloading = true;

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: Icon(
            color: Theme.of(context).colorScheme.primary,
            LineAwesomeIcons.angle_left_solid,
          ),
        ),
        title: Text("Food Details",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
              
            )),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20).w,
              child: Consumer<Donate>(
                builder: (context, value, child) => ClipRRect(
                  borderRadius: BorderRadius.circular(30).w,
                  child: Container(
                    child: Image.network(
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          Future.microtask(
                            () {
                              if (mounted) {
                                setState(() {
                                  _isloading = false;
                                });
                              }
                            },
                          );

                          return child;
                        } else {
                          return Skeletonizer(
                            enabled: true,
                            child: Container(
                              color: Colors.grey.shade100,
                            ),
                          );
                        }
                      },
                      widget.imageurl.toString(),
                      fit: BoxFit.fill,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                    height: 200.h,
                    width: 500.w,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.r, top: 10.h),
              child: ListTile(
                title: Text(
                  widget.foodname.toString(),
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary),
                ),
                subtitle: Text(
                  "${widget.time}",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                trailing: Text(
                  "${widget.option}",
                  style: GoogleFonts.poppins(color: Colors.blue, fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10)
                  .w,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        child: Image.asset('lib/images/avtar.avif'),
                        radius: 30.r,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${widget.user} ${widget.lname}',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${widget.cntctno}",
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    Text(
                      "${widget.course}",
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.r, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About details",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Text(
                        "${widget.itemdes}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 140.h,
            ),
           
            Padding(
              padding: const EdgeInsets.all(20.0).w,
              child: Container(
                height: 60.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 5,),
                    Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    Text(
                      '${widget.cntctno}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.sp),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        onPressed: () {
                          FlutterPhoneDirectCaller.callNumber(
                              "${widget.cntctno}");
                        },
                        child: Text(
                          "call",
                          style: GoogleFonts.poppins(
                              color: Color(0xff247D7F),
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp),
                        ))
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15).w,
                    color: Color(0xff247D7F)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
