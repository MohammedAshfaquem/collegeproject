
import 'package:college_project/Login/lofinpage.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
final _formkey = GlobalKey<FormState>();

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

  String? validatemail(String? email) {
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isemailvalid = emailRegex.hasMatch(email ?? '');
    if (!isemailvalid) {
      return 'Please Enter a valid email';
    }
    return null;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Form(
        key: _formkey,
        child: Stack(
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
                      height: 80.h,
                    ),
                   Image.asset("lib/images/sign.png"),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        validator: validatemail,
                        controller: textcontroller,
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
                          hintText: "Your Email",
                          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
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
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        validator: (value) => value!.length < 3
                            ? 'Password should be atleast 3 characters'
                            : null,
                        obscureText: true,
                        controller: passwordcontroller,
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
                          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
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
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    mainpage(names: 'ASHFAQUE'),
                              ));
                        }
                      },
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
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>loginpage(),
                              )),
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
                    SizedBox(height: 20,),
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        "lib/images/login_bottom.png",
                        color: Colors.lightGreen[200],
                        height: 120.h,
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
