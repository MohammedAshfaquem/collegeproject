
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/donatepage/donateDetailspage.dart';

import 'package:college_project/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';


class Donatepage extends StatelessWidget {
  const Donatepage(
      {super.key, this.showbackbutton = false, required this.onpressed});
  final bool showbackbutton;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    final FireStoreServivce fireStoreServivce = FireStoreServivce();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff247D7F),
        leading: IconButton(
          onPressed: onpressed,
          icon: showbackbutton
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
      backgroundColor: Theme.of(context).colorScheme.surface,
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
              
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String fname = data['first name'];
                    String lname = data['last name'];
                    String number = data['number'];
                    // String course = data['course'];
                    //  File? imageurl = data['image'];
                    // String foodname = data['food name'];
                    // String option = data['option'];
                    // String itemdes = data['decsription'];
                    
                    return Padding(
                      padding: const EdgeInsets.all(28.0).w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detailspage(
                                  // imageurl: imageurl,
                                  cntctno: number,
                                  // course: course,
                                  lname: lname,
                                  // foodname: foodname,
                                  user: fname,
                                  // option: option,
                                  // itemdes: itemdes,
                                ),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(5, 5),
                                    blurRadius: 5),
                              ],
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xff247D7F)),
                          height: 110.h,
                          width: 500.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(5).w,
                              //   child: Container(
                              //     child: imageurl != null
                              //         ? ClipRRect(
                              //             borderRadius:
                              //                 BorderRadius.circular(15),
                              //             child: Image.file(
                              //                 imageurl))
                              //         : CircleAvatar(),
                              //     decoration: BoxDecoration(
                              //         color: Colors.red,
                              //         borderRadius: BorderRadius.circular(7)),
                              //     height: 70.h,
                              //     width: 70.w,
                              //   ),
                              // ),
                              SizedBox(
                                width: 10.w,
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
                                      fname,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 19.sp),
                                    ),
                                    Text(
                                      'course',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade200),
                                    ),
                                    // Text(
                                    //   DateFormat.yMd()
                                    //       .add_jm()
                                    //       .format(time),
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 15.sp),
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              // IconButton(
                              //   onPressed: () {
                              //     QuickAlert.show(
                              //         context: context,
                              //         type: QuickAlertType.warning,
                              //         showCancelBtn: true,
                              //         onCancelBtnTap: () =>
                              //             Navigator.pop(context),
                              //         title: 'Are you sure',
                              //         onConfirmBtnTap: () {
                              //           value.deleteitem(index, context);
                              //           Navigator.pop(context);
                              //         });
                              //   },
                              //   icon: const Icon(Icons.delete),
                              // )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: Text("No Recoreds",style: TextStyle(color: Colors.black,fontSize: 20),));
            }
          }),
    );
  }
}
