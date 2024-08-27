import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Donatepage/donate_controller.dart';
import 'package:college_project/donatepage/donatepage.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:college_project/firestore.dart';
import 'package:college_project/firestoremydonations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class persondetails extends StatelessWidget {
  persondetails({
    super.key,
    required this.foodname,
    required this.description,
    required this.category,
    required this.images,
    required this.option,
  });
  final String foodname;
  final String category;
  final String description;
  final String images;
  final String option;

  @override
  Widget build(BuildContext context) {
    final fnamecontroller = TextEditingController();
    final Lnamecontroller = TextEditingController();
    final Contactnocontroller = TextEditingController();
    final controller = Provider.of<Donate>(context, listen: false);

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<void> addItemToUser(ItemModel itemModel) async {
      try {
        // Reference to the specific user's document
        final userId = FirebaseAuth.instance.currentUser!.uid;
        DocumentReference userRef = _firestore.collection('users').doc(userId);

        // Update the document with the new field
        await userRef.update({
           'mydonations': FieldValue.arrayUnion([itemModel.toMap()]), // Adding the itemModel as a field
        });

        print('Item added to user document successfully!');
      } catch (e) {
        print('Error adding item to user document: $e');
      }
    }

    final FireStoreService fireStoreService = FireStoreService();
    final FireStoreServivce fireStoreServivce = FireStoreServivce();
    final now = DateTime.now();

    final _formkey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
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
                            ? 'Please enter your  last name'
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
                                  color: Theme.of(context).colorScheme.primary),
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(25),
                              underline: SizedBox(),
                              dropdownColor: Color(0xff247D7F),
                              padding: EdgeInsets.all(10),
                              value: value.selectedvalue,
                              hint: Text("Select your course"),
                              items: value.dropdowmitems.map(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                },
                              ).toList(),
                              onChanged: value.coursecontroll,
                            )),
                      ),
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
                      if (_formkey.currentState!.validate()) {
                        await addItemToUser(
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
                            option: value.currentvalue.toString(),
                          ),
                        );
                        // value.addtile(
                        //   ItemModel(
                        //     image: images,
                        //     category: category,
                        //     foodname: foodname,
                        //     description: description,
                        //     date: DateTime.now(),
                        //     lname: Lnamecontroller.text,
                        //     fname: fnamecontroller.text,
                        //     course: value.selectedvalue.toString(),
                        //     cntctbo: Contactnocontroller.text,
                        //     option: value.currentvalue.toString(),
                        //   ),
                        // );
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          title: 'Thankyou for your Donation',
                          animType: QuickAlertAnimType.scale,
                          showCancelBtn: true,
                          onConfirmBtnTap: () {
                            fireStoreService.addNote(
                              fnamecontroller.text,
                              Lnamecontroller.text,
                              Contactnocontroller.text,
                              foodname,
                              value.selectedvalue.toString(),
                              value.currentvalue.toString(),
                              description,
                              value.imageurl.toString(),
                              DateTime.now(),
                            );
                            fireStoreServivce.addmydonation(
                              fnamecontroller.text,
                              Lnamecontroller.text,
                              Contactnocontroller.text,
                              foodname,
                              value.selectedvalue.toString(),
                              value.currentvalue.toString(),
                              description,
                              value.imageurl.toString(),
                              DateTime.now(),
                            );

                            value.image = null;
                            fnamecontroller.clear();
                            Contactnocontroller.clear();
                            Lnamecontroller.clear();
                            value.selectedvalue = null;
                            value.currentvalue = null;
                            value.clearImageCache();
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
                        // That's it to display an alert, use other properties to customize.
                      }
                      ;
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
