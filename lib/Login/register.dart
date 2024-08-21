import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Editimage/imagecontroller.dart';
import 'package:college_project/Login/login.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:college_project/service/googlesign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  String? validatemail(String? email) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isemailvalid = emailRegex.hasMatch(email ?? '');
    if (!isemailvalid) {
      return 'Please Enter a valid email';
    }
    return null;
  }

  bool passwordconfirmed() {
    if (regpasswordcontroller.text.trim() ==
        regconfirmpasscontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future signupemail() async {
    if (passwordconfirmed()) {
      try {
        // await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //   email: regemailcontroller.text.trim(),
        //   password: regpasswordcontroller.text.trim(),
        // );
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: regemailcontroller.text,
                password: regpasswordcontroller.text);
        String uid = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'email': regemailcontroller.text,
          'name': regnamecontroller.text,
          'password': regpasswordcontroller.text,
          'confirm pass': regconfirmpasscontroller.text,
        });
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
      body: Stack(
        children: [
          Container(
            height: 825.h,
            width: 400.w,
          ),
          Image.asset(
            "lib/images/main_top.png",
            height: 150.h,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 0.h,
                  ),
                  Image.asset("lib/images/sign.png"),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      // validator: validatemail,
                      controller: regnamecontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.green.shade100,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xff247D7F)),
                          borderRadius: BorderRadius.circular(35).r,
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35).r),
                        hintText: "Name",
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35).r,
                          borderSide:
                              const BorderSide(color: Color(0xff247D7F)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      // validator: validatemail,
                      controller: regemailcontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.green.shade100,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.green,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xff247D7F)),
                          borderRadius: BorderRadius.circular(35).r,
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35).r),
                        hintText: "Your Email",
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35).r,
                          borderSide:
                              const BorderSide(color: Color(0xff247D7F)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      // validator: (value) => value!.length < 3
                      //     ? 'Password should be atleast 3 characters'
                      //     : null,
                      obscureText: true,
                      controller: regpasswordcontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.green.shade100,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xff247D7F)),
                          borderRadius: BorderRadius.circular(35).r,
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35).r),
                        hintText: "passwords",
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35).r,
                          borderSide:
                              const BorderSide(color: Color(0xff247D7F)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      // validator: (value) => value!.length < 3
                      //     ? 'Password should be atleast 3 characters'
                      //     : null,
                      obscureText: true,
                      controller: regconfirmpasscontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.green.shade100,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xff247D7F)),
                          borderRadius: BorderRadius.circular(35).r,
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35).r),
                        hintText: "confirm passwords",
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35).r,
                          borderSide:
                              const BorderSide(color: Color(0xff247D7F)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 5.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  GestureDetector(
                    onTap: () => signupemail(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff247D7F),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        height: 55.h,
                        width: 390.w,
                        child: const Center(
                          child: Text(
                            "SIGNUP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      GestureDetector(
                        onTap: widget.showloginpage,
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Color(0xff247D7F),
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      GoogleSignin().signInWithGoogle(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff247D7F),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 55.h,
                        width: 350.w,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100).w,
                                  child: Image.asset(
                                    'lib/images/google.png',
                                    height: 35,
                                  )),
                              Text(
                                "Continue With Google",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
