import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Login/emailverification.dart';
import 'package:college_project/Login/registerformfieldmodel.dart';

import 'package:college_project/service/googlesign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
final _formkey = GlobalKey<FormState>();

class RegisterPage extends StatefulWidget {
  final VoidCallback showloginpage;
  const RegisterPage({
    super.key,
    required this.showloginpage,
  });

  @override
  State<RegisterPage> createState() => _RegisterpageState();
}

// ignore: camel_case_types
class _RegisterpageState extends State<RegisterPage> {
  final regemailcontroller = TextEditingController();
  final regpasswordcontroller = TextEditingController();
  final regnamecontroller = TextEditingController();
  final regconfirmpasscontroller = TextEditingController();
  bool value = false;
  String? validatemail(String? email) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isemailvalid = emailRegex.hasMatch(email ?? '');
    if (!isemailvalid) {
      return 'Please Enter a valid email';
    }
    return null;
  }

  bool passwordConfirmed() {
    if (regpasswordcontroller.text.trim() ==
        regconfirmpasscontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }
Future<void> signupEmail() async {
  if (passwordConfirmed()) {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: regemailcontroller.text.trim(),
              password: regpasswordcontroller.text.trim());
      // Send email verification
      await userCredential.user?.sendEmailVerification();
      // Save user data and creation timestamp to Firestore
      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': regemailcontroller.text,
        'name': regnamecontroller.text,
        'emailVerified': false,
        'createdAt': FieldValue.serverTimestamp(), // Store creation time
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyEmailPage(),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            e.toString(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }
}


  @override
  void dispose() {
    super.dispose();
    regemailcontroller.dispose();
    regpasswordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Container(
            height: 800.h,
            width: 420.w,
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          "lib/images/bg1.avif",
                          height: 230.h,
                        )),
                    Positioned(
                      top: 100.h,
                      left: 20.w,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Lets's Get Started",
                          style: GoogleFonts.poppins(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 140.h,
                      left: 20.w,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Fill the form to continue",
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20,top: 20),
                //   child: Align(
                //     alignment: Alignment.bottomLeft,
                //     child: Text(
                //       "Enter your details",
                //       style: GoogleFonts.poppins(
                //           fontSize: 25,
                //           color: Colors.black,
                //           fontWeight: FontWeight.w600),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Registerfield(
                            controller: regnamecontroller,
                            hintText: "Name",
                            icon: Icons.person,
                            obscuretext: false),
                        SizedBox(
                          height: 15.h,
                        ),
                        Registerfield(
                            controller: regemailcontroller,
                            hintText: "Your email",
                            icon: Icons.email,
                            obscuretext: false),
                        SizedBox(
                          height: 15.h,
                        ),
                        Registerfield(
                            controller: regpasswordcontroller,
                            hintText: "password",
                            icon: Icons.lock,
                            obscuretext: true),
                        SizedBox(
                          height: 15.h,
                        ),
                        Registerfield(
                            controller: regconfirmpasscontroller,
                            hintText: "confirm password",
                            icon: Icons.lock,
                            obscuretext: true),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "i agree with terms and use",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 120.w,
                            ),
                            CupertinoSwitch(
                              trackColor: Colors.black,
                              activeColor: Color(0xff247D7F),
                              value: value,
                              onChanged: (newvalue) {
                                setState(() {
                                  value = !value;
                                });
                              },
                              focusColor: Colors.white,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        GestureDetector(
                          onTap: () => signupEmail(),
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff247D7F),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 55.h,
                              width: 390.w,
                              child: Center(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 2.h,
                              width: 150.w,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              "OR",
                              style: GoogleFonts.poppins(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              height: 2.h,
                              color: Colors.grey,
                              width: 150.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            GoogleSignin().signInWithGoogle(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.r),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 55.h,
                              width: 390.w,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100).w,
                                        child: Image.asset(
                                          'lib/images/google.png',
                                          height: 30.h,
                                        )),
                                    Text(
                                      "Sign up with Google",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            GestureDetector(
                              onTap: widget.showloginpage,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Color(0xff247D7F),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.sp),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
