import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:college_project/donatepage/donateDetailspage.dart';
import 'package:college_project/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
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
    final FireStoreService fireStoreService = FireStoreService();
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
          leading: IconButton(
            onPressed: widget.onpressed,
            icon: widget.showbackbutton
                ? Icon(
                    LineAwesomeIcons.angle_left_solid,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : SizedBox(),
          ),
          elevation: 2,
          title: Text('Available Foods',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Theme.of(context).colorScheme.primary)),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: StreamBuilder<QuerySnapshot>(
            stream: fireStoreService.getNotesStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the future is still loading
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If there was an error while fetching data
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // If data is available
                final notesList = snapshot.data!.docs;
                if (notesList.isNotEmpty) {
                  // Data exists and is not empty
                  return ListView.builder(
                      itemCount: notesList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = notesList[index];
                        String docID = document.id;
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String fname = data['first name'] ?? '';
                        String lname = data['last name'] ?? '';
                        String number = data['number'] ?? '';
                        String course = data['course'] ?? '';
                        String foodname = data['food name'] ?? '';
                        String option = data['option'] ?? '';
                        String itemdes = data['description'] ?? '';
                        String imageurl = data['image'] ?? '';
                        String dateTime = data['time'] ?? '';

                        return Padding(
                          padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 15)
                              .r,
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
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      imageurl,
                                      fit: BoxFit.cover,
                                      width: 120.w,
                                      height: 90.h,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Skeletonizer(
                                            enabled: true,
                                            child: Container(
                                              color: Colors.grey.shade100,
                                              height: 90.h,
                                              width: 120.w,
                                            ));
                                      },
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
                                        Text(
                                          foodname,
                                          style: GoogleFonts.poppins( fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 19.sp)
                                        ),
                                        Text(
                                          course,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          dateTime.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.sp,
                                              
                                              color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    option,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  // Data is either null or empty
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 190,
                        ),
                        Container(
                          height: 200,
                          child: Lottie.asset("lib/Animations/emtypage.json",
                              repeat: false, fit: BoxFit.fill),
                        ),
                        Text(
                          "No Data Dound!",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                // Handle the case where snapshot has no data but no error (shouldn't usually reach here)
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 190,
                      ),
                      Container(
                        height: 200,
                        child: Lottie.asset("lib/Animations/emtypage.json",
                            repeat: false, fit: BoxFit.fill),
                      ),
                      Text(
                        "No Data Dound!",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
