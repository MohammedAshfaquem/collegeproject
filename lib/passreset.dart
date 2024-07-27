import 'package:college_project/profiepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class passresetpage extends StatefulWidget {
  const passresetpage({super.key});

  @override
  State<passresetpage> createState() => _passresetpageState();
}

class _passresetpageState extends State<passresetpage> {
  final resetcontroller = TextEditingController();

  @override
  void dispose() {
    resetcontroller.dispose();
    super.dispose();
  }

  Future reset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetcontroller.text.trim());
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Reset link sended to your email"),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: Icon(
            LineAwesomeIcons.angle_left_solid,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset(
                'lib/images/update-concept-illustration.png',
                height: 300.h,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Please enter your email address and we'll send you  al link to reset your password",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextField(
              controller: resetcontroller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12).w,
                ),
                hintText: "Enter your email",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12).w,
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onDoubleTap: reset,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff247D7F),
                        borderRadius: BorderRadius.circular(30).r),
                    height: 50.h,
                    width: 180.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Reset Password",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.arrow_right_alt_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
