import 'package:college_project/auth/auth_service.dart';
import 'package:college_project/Login/forgetpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterpage;
  const LoginPage({
    super.key,
    required this.showRegisterpage,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final textcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  var _isobscured;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isobscured = true;
  }

  // String? validatemail(String? email) {
  //   RegExp emailRegex = RegExp(
  //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  //   final isemailvalid = emailRegex.hasMatch(email ?? '');
  //   if (!isemailvalid) {
  //     return 'Please Enter a valid email';
  //   }
  //   return null;
  // }

  // Future signInemail() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: textcontroller.text, password: passwordcontroller.text);
  // }
  void loginemail() async {
    final authservice = Authservice();

    try {
      
      await authservice.signInWithEmailAndPassword(
          textcontroller.text, passwordcontroller.text);
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

  @override
  void dispose() {
    super.dispose();
    textcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Container(
          height: 800.h,
          width: 420.w,
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                 
                 Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                "lib/images/bg1.avif",
                height: 260,
                
              )),
                
                  Positioned(
                    top: 80.h,
                    left: 10.w,
                    child: Container(
                      height: 300.h,
                      width: 400.w,
                     
                      child: Image.asset(
                        "lib/images/unity.png",
                        height: 250.h,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.h, left: 20.r),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),

                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Email Adress",
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.r),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          // validator: validatemail,
                          controller: textcontroller,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: Colors.black,
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15).r,
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15).r),
                            hintText: "  Your Email",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15).r,
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "password",
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding:EdgeInsets.only(right: 20.r),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          // validator: (value) => value!.length < 3
                          //      ? 'Password should be atleast 3 characters'
                          //     : null,
                          obscureText: _isobscured,
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            // prefixIcon: Icon(
                            //   Icons.lock,
                            //   color: Colors.black,
                            // ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isobscured = !_isobscured;
                                  });
                                },
                                icon: _isobscured
                                    ? Icon(Icons.visibility_off,
                                        color: Colors.grey)
                                    : Icon(Icons.visibility,
                                        color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15).r,
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15).r),
                            hintText: "  passwords",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15).r,
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 5.h,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Forgetpage(),
                                )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, right: 25).w,
                              child: Text("Forget password?",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xff247D7F),
                                      fontWeight: FontWeight.w500)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GestureDetector(
                        onTap: () => loginemail(),
                        child: Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff247D7F),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            height: 55.h,
                            width: 390.w,
                            child: Center(
                              child: Text("LOGIN",
                                  style: GoogleFonts.poppins(
                                      letterSpacing: 2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 65.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 103, 96, 96)),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: widget.showRegisterpage,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Color(0xff247D7F),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp),
                            ),
                          )
                        ],
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   alignment: Alignment.bottomRight,
                      //   child: Image.asset(
                      //     "lib/images/login_bottom.png",
                      //     color: Colors.lightGreen[200],
                      //     height: 120.h,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
