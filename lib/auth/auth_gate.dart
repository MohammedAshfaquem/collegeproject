
import 'package:college_project/Login/emailverification.dart';
import 'package:college_project/Main%20Page/mainpage.dart';
import 'package:college_project/auth/auth_page.dart';
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
            if(FirebaseAuth.instance.currentUser!.emailVerified == true){
              return MainPage();
            }
            return VerifyEmailPage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
