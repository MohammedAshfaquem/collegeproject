import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:college_project/donatepage/donateDetailspage.dart';
import 'package:college_project/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Donatepage extends StatefulWidget {
  Donatepage({super.key, this.showbackbutton = false, required this.onpressed});
  final bool showbackbutton;
  final VoidCallback onpressed;

  @override
  State<Donatepage> createState() => _DonatepageState();
}

class _DonatepageState extends State<Donatepage> {
  @override
  Widget build(BuildContext context) {
    final FireStoreService fireStoreServivce = FireStoreService();
    return WillPopScope(
      onWillPop: () async {
        // Navigate to the home page when the back button is pressed
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          (Route<dynamic> route) => false,
        );
        return false; // Prevent default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff247D7F),
          leading: IconButton(
            onPressed: widget.onpressed,
            icon: widget.showbackbutton
                ? Icon(
                    LineAwesomeIcons.angle_left_solid,
                  )
                : SizedBox(),
          ),
          title: Text(
            'Available Donations',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: Theme.of(context).colorScheme.surface),
          ),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: StreamBuilder<QuerySnapshot>(
            stream: fireStoreServivce.getNotesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List noteslist = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: noteslist.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = noteslist[index];
                      String docID = document.id;
                      Map<dynamic, dynamic> data =
                          document.data() as Map<dynamic, dynamic>;
                      String fname = data['first name'];
                      String lname = data['last name'];
                      String number = data['number'];
                      String course = data['course'];
                      String foodname = data['food name'];
                      String option = data['option'];
                      String itemdes = data['decsription'];
                      String imageurl = data['image'];
                      String dateTime = data['time'];

                      return Padding(
                        padding: const EdgeInsets.all(28.0).w,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detailspage(
                                    cntctno: number,
                                    course: course,
                                    lname: lname,
                                    foodname: foodname,
                                    user: fname,
                                    option: option,
                                    itemdes: itemdes,
                                    imageurl: imageurl,
                                    time: dateTime,
                                  ),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            height: 120.h,
                            width: 500.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20).w,
                                  child: Container(
                                    
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        imageurl,
                                        fit: BoxFit.fill,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Skeletonizer(
                                              enabled: true,
                                              child: Container(
                                                color: Colors.grey.shade100,
                                                height: 120,
                                                width:100,
                                              ));
                                        },
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7)),
                                    height: 90.h,
                                    width: 120.w,
                                  ),
                                ),
                               
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        foodname,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 19.sp),
                                      ),
                                      Text(
                                        course,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        dateTime.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                            color: Colors.black),
                                      ),
                                    SizedBox(height: 10,)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                              Text(option,style: TextStyle(color: Colors.black),),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                    child: Text(
                  "No Recoreds",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ));
              }
            }),
      ),
    );
  }
}
