import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Donatepage/donate_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyDonations extends StatelessWidget {
  const MyDonations({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List?> getmydonation() async {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userdoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      print(userdoc.id);
      if (userdoc.exists) {
        var data = userdoc.data() as Map<String, dynamic>;
        print(data['mydonations']);
        return data['mydonations'] as List?;
      }
      return null;
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(LineAwesomeIcons.angle_left_solid,
                  color: Theme.of(context).colorScheme.primary)),
          title: Text('My Donations',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: Theme.of(context).colorScheme.primary)),
          centerTitle: true,
        ),
        body: Consumer<Donate>(
          builder: (context, value, child) => FutureBuilder(
            future: getmydonation(), // Your future function
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the future is still loading
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If there was an error while fetching data
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // If data is available
                final data =
                    snapshot.data as List<dynamic>?; // Ensure type safety here

                if (data != null && data.isNotEmpty) {
                  // Data exists and is not empty
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 15),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => Detailspage(
                            //         cntctno: number,
                            //         course: course,
                            //         lname: lname,
                            //         foodname: foodname,
                            //         user: fname,
                            //         option: option,
                            //         itemdes: itemdes,
                            //         imageurl: imageurl,
                            //         time: dateTime,
                            //       ),
                            //     ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            height: 110.h,
                            width: 500.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20).w,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image.network(
                                          item['image'],
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Skeletonizer(
                                                enabled: true,
                                                child: Container(
                                                  color: Colors.grey.shade100,
                                                  height: 100,
                                                  width: 80,
                                                ));
                                          },
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      height: 80.h,
                                      width: 100.w,
                                    ),
                                  ),
                                ),
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
                                        item['foodname'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 19.sp),
                                      ),
                                      Text(
                                        item['course'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        item['date'],
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
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
                                IconButton(
                                  onPressed: () {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.warning,
                                      showCancelBtn: true,
                                      onCancelBtnTap: () =>
                                          Navigator.pop(context),
                                      title: 'Are you sure',
                                      onConfirmBtnTap: () {
                                        print(index);
                                        value.deleteFromMyDonations(
                                          index,
                                        );
                                        print(item['donationid']);
                                        value.deleteFromAvailbleDanations(
                                            'notes',
                                            'donationid',
                                            index,
                                            item['donationid']);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
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
            },
          ),
        ));
  }
}
