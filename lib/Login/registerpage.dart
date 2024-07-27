import 'package:college_project/Login/forgetpage.dart';
import 'package:college_project/Login/lofinpage.dart';
import 'package:college_project/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class Registerpage extends StatefulWidget {
  const Registerpage({
    super.key,
  });

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

// ignore: camel_case_types
class _RegisterpageState extends State<Registerpage> {
  final textcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Future signup() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: textcontroller.text.trim(),
        password: passwordcontroller.text.trim());
  }

  @override
  void dispose() {
    super.dispose();
    textcontroller.dispose();
    passwordcontroller.dispose();
  }

  String? validatemail(String? email) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isemailvalid = emailRegex.hasMatch(email ?? '');
    if (!isemailvalid) {
      return 'Please Enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: Stack(
          children: [
            Image.asset(
              "lib/images/main_top.png",
              height: 150.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,).r,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Image.asset(
                      'lib/images/sign UP.png',
                      height: 300,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20).r,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(35).w),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: validatemail,
                          controller: textcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xff247D7F)),
                              borderRadius: BorderRadius.circular(35).w,
                            ),
                            hintText: "Your Email",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35).w,
                              borderSide:
                                  const BorderSide(color: Color(0xff247D7F)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20).r,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(35).w),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter you password' : null,
                          obscureText: true,
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.green,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xff247D7F)),
                              borderRadius: BorderRadius.circular(35).w,
                            ),
                            hintText: "passwords",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide:
                                  const BorderSide(color: Color(0xff247D7F)),
                            ),
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
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    mainpage(names: textcontroller.text),
                              ));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20).r,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff247D7F),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          height: 55.h,
                          width: 390.w,
                          child: const Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w700),
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
                          "Already have an account ?",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => loginpage(),
                              )),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Color(0xff247D7F),
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("OR")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey),
                          height: 50.h,
                          width: 50.w,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100).w,
                              child: Image.asset('lib/images/google.png')),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100).w,
                              color: const Color.fromARGB(255, 234, 29, 29)),
                          height: 50.h,
                          width: 50.w,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100).r,
                              child: Image.asset('lib/images/email1.png')),
                        ),
                      ],
                    ),
                     Padding(
                       padding: const EdgeInsets.only(left: 240,bottom: 10),
                       child: Image.asset(
                                     "lib/images/login_bottom.png",
                                     color: Colors.lightGreen[200],
                                     height: 100.h,
                                   ),
                     ),
                  ],
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
