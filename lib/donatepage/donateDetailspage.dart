import 'package:college_project/donatepage/donatecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    String fotmatter = DateFormat.yMd().add_jm().format(now);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: Icon(
            color: Theme.of(context).colorScheme.primary,
            LineAwesomeIcons.angle_left_solid,
          ),
        ),
        title: Text(
          "Item Details",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20).w,
              child: Consumer<DonateController>(
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
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                    height: 150.h,
                    width: 500.w,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.r, top: 20.h),
              child: ListTile(
                title: Text(
                  widget.foodname.toString(),
                  style: TextStyle(
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
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0).w,
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
                      Text(
                        '${widget.user} ${widget.lname}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Text(
                        "${widget.cntctno}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 100.w,
                  ),
                  Text(
                    "${widget.course}",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary),
                  )
                ],
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
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
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
              height: 170.h,
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0).w,
              child: Container(
                height: 60.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    Text(
                      '${widget.cntctno}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                    ),
                    SizedBox(
                      width: 40.w,
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
                          style: TextStyle(
                              color: Color(0xff247D7F),
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp),
                        ))
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27).w,
                    color: Color(0xff247D7F)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
