import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Login/login.dart';
import 'package:college_project/Login/loginorsignup.dart';
import 'package:college_project/Login/signup.dart';
import 'package:college_project/auth/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startVerificationTimer();
  }

  void startVerificationTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await _auth.currentUser?.reload();
      if (_auth.currentUser?.emailVerified ?? false) {
        timer.cancel();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({'emailVerified': true});
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthGate()),
        );
      }
    });

    // Set a timeout to delete the user if not verified in 10 minutes
    Timer(Duration(minutes: 10), () async {
      if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
        try {
          await _auth.currentUser!.delete();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .delete(); // Remove the user from Firestore
          // Optionally navigate to a different page or show a message
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AuthGate()),
          );
        } catch (e) {
          // Handle errors if user deletion fails
          print("Error deleting user: $e");
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Your Email')),
      body: Center(
        child: Column(
          children: [
            Icon(
              Icons.email_outlined,
              size: 150,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Verify your email address.',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Text(
              "We have just send email verification link on \n your email.please check email and click on \n      that link to verify your email address",
              style: TextStyle(color: Colors.grey.shade900),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "if not auto redirected  after verification ,then \n               please reload this page.",
              style: TextStyle(color: Colors.grey.shade900),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                await _auth.currentUser?.sendEmailVerification();
              },
              child: Text(
                'Resend  E-mail link',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(
                        showloginpage: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(showRegisterpage: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => loginorsignup(),));
                          }),));
                        },
                      ),
                    ));
              },
              child: Text(
                "Back to login",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
