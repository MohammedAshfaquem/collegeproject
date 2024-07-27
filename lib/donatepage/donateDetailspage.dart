import 'package:college_project/donatepage/donatecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class Detailspage extends StatelessWidget {
  var foodname;
  var itemdes;
  var user;
  var cntctno;
  var course;
  var imageurl;
  var option;
  var lname;

  Detailspage(
      {super.key,
      required this.lname,
       this.option,
       this.foodname,
      this.itemdes,
      this.user,
      this.cntctno,
      this.course,
      this.imageurl});

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String fotmatter = DateFormat.yMd().add_jm().format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Details",style: TextStyle(fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20).w,
              child: Consumer<Donatecontroler>(
                builder: (context, value, child) => ClipRRect(
                  borderRadius: BorderRadius.circular(30).w,
                  child: Container(
                    child: Image.file(
                      value.savedimage!,
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
              padding:  EdgeInsets.only(left: 20.r, top: 20.h),
              child: ListTile(
                title: Text(foodname.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: Text(fotmatter),
                trailing: Text(
                  "$option",
                  style: TextStyle(color: Colors.blue,fontSize: 15),
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
                    Text('${user} ${lname}',style: TextStyle(fontWeight: FontWeight.w500),),
                      Text("$cntctno"),
                    ],
                  ),
                  SizedBox(
                    width: 100.w,
                  ),
                  Text(
                    "$course",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
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
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      Text("$itemdes"),
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
              padding: const EdgeInsets.all(30.0).w,
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
                      '$cntctno',
                      style: TextStyle(
                          color: Colors.white,
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
                          FlutterPhoneDirectCaller.callNumber("$cntctno");
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
