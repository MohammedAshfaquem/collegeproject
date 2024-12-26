import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Donatepage/donate_controller.dart';
import 'package:college_project/Notification/sendnotification.dart';
import 'package:college_project/category/quantitycontroller.dart';
import 'package:college_project/donatepage/donatepage.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:college_project/firestore.dart';
import 'package:college_project/firestoremydonations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

// ignore: must_be_immutable
class PersonDetails extends StatelessWidget {
  final String foodname;
  final String category;
  final String description;
  final String images;
  final String option;
  final String quantity;

  PersonDetails({
    super.key,
    required this.foodname,
    required this.category,
    required this.description,
    required this.images,
    required this.option,
    required this.quantity,
  });
  void showCustomSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String generateRandomId({int length = 16}) {
      const characters =
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      final random = Random();
      return List.generate(
          length, (_) => characters[random.nextInt(characters.length)]).join();
    }

    final fnamecontroller = TextEditingController();
    final Lnamecontroller = TextEditingController();
    final Contactnocontroller = TextEditingController();
    final categerycontroller = Provider.of<QuantityController>(context);
    final donationId = generateRandomId();

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<void> addItemToUser(ItemModel itemModel) async {
      try {
        // Reference to the specific user's document
        final userId = FirebaseAuth.instance.currentUser!.uid;
        DocumentReference userRef = _firestore.collection('users').doc(userId);

        // Update the document with the new field
        await userRef.update({
          'mydonations': FieldValue.arrayUnion(
              [itemModel.toMap()]), // Adding the itemModel as a field
        });

        print('Item added to user document successfully!');
      } catch (e) {
        print('Error adding item to user document: $e');
      }
    }

    bool _isloading = true;
    final FireStoreService fireStoreService = FireStoreService();
    final FireStoreServivce fireStoreServivce = FireStoreServivce();
    final now = DateTime.now();
    final _courseformkey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _courseformkey,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 230.h,
                    color: Color(0xff247D7F),
                  ),
                  Container(
                    height: 600.h,
                    width: 550.w,
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
              Positioned(
                top: 170.h,
                right: 30.r,
                child: Container(
                  padding: EdgeInsets.all(18).w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        validator: (name) => name!.isEmpty
                            ? 'Please enter your first name'
                            : null,
                        controller: fnamecontroller,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary), // When the field is focused
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // When the field is not focused
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // When the field is not focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // When the field is not focused
                          ),
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        validator: (name) => name!.isEmpty
                            ? 'Please enter your last name'
                            : null,
                        controller: Lnamecontroller,
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary), // When the field is focused
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // When the field is not focused
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // When the field is not focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // When the field is not focused
                          ),
                        ),
                      ),
                      Consumer<Donate>(
                          builder: (context, value, child) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey)),
                              height: 60,
                              width: 300,
                              child: DropdownButton<String>(
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(25),
                                dropdownColor: Color(0xff247D7F),
                                padding: EdgeInsets.all(10),
                                value: value.selectedvalue,
                                hint: Text("Select your course"),
                                // validator: (val) {
                                //   if (val == null || val.isEmpty) {
                                //     // Show the SnackBar if the value is empty or null
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(
                                //         content: Text(
                                //           'Please select your course', // The error message
                                //           style: TextStyle(color: Colors.white),
                                //         ),
                                //         backgroundColor: Colors
                                //             .red, // Optional: Set background color
                                //         duration: Duration(
                                //             seconds:
                                //                 2), // Duration of the SnackBar
                                //       ),
                                //     );
                                //   }
                                //   return null;
                                // },
                                items: value.dropdowmitems.map(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style: GoogleFonts.poppins(
                                                color: Colors.black)));
                                  },
                                ).toList(),
                                onChanged: (newValue) {
                                  value.coursecontroll(
                                      newValue); // This will update the selectedvalue
                                },
                              ))),
                      TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        validator: (name) => name!.isEmpty || name.length < 10
                            ? 'Please enter your Phone no'
                            : null,
                        controller: Contactnocontroller,
                        decoration: InputDecoration(
                          hintText: 'Phone no',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary), // When the field is focused
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // When the field is not focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // When the field is not focused
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // When the field is not focused
                          ),
                        ),
                      ),
                    ],
                  ),
                  height: 450.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25).w,
                      color: Theme.of(context).colorScheme.surface),
                ),
              ),
              Positioned(
                bottom: 120.h,
                left: 40.r,
                child: Consumer<Donate>(
                  builder: (context, value, child) => GestureDetector(
                    onTap: () async {
                      final now = DateTime.now();
                      final int currentHour = now.hour;

                      // Check if the current time is between 9:00 AM and 4:00 PM
                      if (currentHour < 9) {
                        // Show message if donation is attempted before 9:00 AM
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'Donation Not Allowed Yet',
                          text: 'Donations are only allowed after 9:00 AM.',
                          confirmBtnText: 'OK',
                          onConfirmBtnTap: () {
                            Navigator.pop(context);
                          },
                        );
                      } else if (currentHour >= 16) {
                        // Show message if donation is attempted after 4:00 PM
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          title: 'Donation Not Allowed',
                          text: 'Donations are not possible after 4:00 PM.',
                          confirmBtnText: 'OK',
                          onConfirmBtnTap: () {
                            Navigator.pop(context);
                          },
                        );
                      } else {
                        // Proceed with donation if it's between 9:00 AM and 4:00 PM
                        if (_courseformkey.currentState!.validate()) {
                          if (value.selectedvalue == null ||
                              value.selectedvalue!.isEmpty) {
                            showCustomSnackBar(
                                context, "Please select a course.");
                            return;
                          }
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.confirm,
                            title: 'Thank you for your Donation!',
                            animType: QuickAlertAnimType.scale,
                            showCancelBtn: true,
                            onConfirmBtnTap: () {
                              // Process the donation logic here
                              sendTopicNotificationv2(
                                  value.selectedvalue.toString());
                              addItemToUser(
                                ItemModel(
                                  image: images,
                                  category: category,
                                  foodname: foodname,
                                  description: description,
                                  date: DateTime.now(),
                                  lname: Lnamecontroller.text,
                                  fname: fnamecontroller.text,
                                  course: value.selectedvalue.toString(),
                                  cntctbo: Contactnocontroller.text,
                                  option: option,
                                  donationId: donationId,
                                  quantity: quantity,
                                ),
                              );
                              fireStoreService.addNote(
                                fnamecontroller.text,
                                Lnamecontroller.text,
                                Contactnocontroller.text,
                                foodname,
                                value.selectedvalue.toString(),
                                option,
                                description,
                                value.imageurl.toString(),
                                DateTime.now(),
                                donationId.toString(),
                                quantity.toString(),
                              );
                              fireStoreServivce.addmydonation(
                                fnamecontroller.text,
                                Lnamecontroller.text,
                                Contactnocontroller.text,
                                foodname,
                                option,
                                value.currentvalue.toString(),
                                description,
                                value.imageurl.toString(),
                                DateTime.now(),
                                donationId.toString(),
                                quantity.toString(),
                              );

                              // Clear input fields and reset values after donation is processed
                              value.image = null;
                              fnamecontroller.clear();
                              Contactnocontroller.clear();
                              Lnamecontroller.clear();
                              value.selectedvalue = null;
                              value.currentvalue = null;
                              value.clearImageCache();
                              categerycontroller.reset();

                              // Navigate to the donation page or main page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Donatepage(
                                    showbackbutton: true,
                                    onpressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainPage(),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "Donate",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp),
                      )),
                      decoration: BoxDecoration(
                          color: Color(0xff247D7F),
                          borderRadius: BorderRadius.circular(50)),
                      height: 60.h,
                      width: 350.w,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30.r,
                top: 70.h,
                child: Text(
                  "Person Details!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
