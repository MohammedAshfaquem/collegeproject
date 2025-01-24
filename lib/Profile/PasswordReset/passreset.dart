import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PassResetPage extends StatefulWidget {
  const PassResetPage({super.key});

  @override
  State<PassResetPage> createState() => _PassResetPageState();
}

class _PassResetPageState extends State<PassResetPage> {
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
            return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      title: const Text(
        "Password Reset",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      content:  Text(
        "A reset link has been sent to your email.",
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 16.0,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog
          },
          child: Text(
            "OK",
            style: TextStyle(
              color: Theme.of(context).primaryColor, // Use app theme color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString(),style: TextStyle(color: Colors.black,),),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
         appBar: AppBar(
        backgroundColor: Color(0xff247D7F),
        centerTitle: true,
        title: Text(
          "Reset",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
          leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: Icon(
            
            LineAwesomeIcons.angle_left_solid,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0).w,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
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
                style: GoogleFonts.poppins(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Please enter your email address and we'll send you  al link to reset your password",
                style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                controller: resetcontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12).w,
                  ),
                  hintText: "Enter your email",
                  hintStyle:TextStyle(color: Theme.of(context).colorScheme.primary) ,
                  helperStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
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
                    onTap: reset,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff247D7F),
                          borderRadius: BorderRadius.circular(15).r),
                      height: 50.h,
                      width: 110.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Reset",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          // Icon(
                          //   Icons.arrow_right_alt_rounded,
                          //   color: Colors.white,
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
