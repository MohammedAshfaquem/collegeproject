import 'package:college_project/Login/forgetpage.dart';
import 'package:college_project/Login/registerpage.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
final _formkey = GlobalKey<FormState>();

class loginpage extends StatefulWidget {
  const loginpage({
    super.key,
  });

  @override
  State<loginpage> createState() => _loginpageState();
}

// ignore: camel_case_types
class _loginpageState extends State<loginpage> {
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
              padding:  EdgeInsets.only(top: 30.h, left: 20.r),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    Image.asset('lib/images/loginpage.png'),
                    Padding(
                      padding:  EdgeInsets.only(right: 20.r),
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
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Forgetpage(),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, right: 25).w,
                            child: const Text(
                              "Forget password?",
                              style: TextStyle(
                                  color: Color(0xff247D7F),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
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
                        padding: EdgeInsets.only(right: 20.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff247D7F),
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                          height: 55.h,
                          width: 390.w,
                          child: const Center(
                            child: Text(
                              "LOGIN",
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
                          "Don't have an Account ?",
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
                                builder: (context) => Registerpage(),
                              )),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color(0xff247D7F),
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp),
                          ),
                        )
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
