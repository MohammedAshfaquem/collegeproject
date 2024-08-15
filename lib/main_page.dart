import 'package:college_project/Homepage/homepage.dart';
import 'package:college_project/Login/login.dart';
import 'package:college_project/Login/loginorsignup.dart';
import 'package:college_project/Login/register.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return mainpage();
          } else {
            return loginorsignup();
          }
        },
      ),
    );
  }
}
