import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:college_project/auth/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  FirebaseAuth _auth =FirebaseAuth.instance;
  late Timer timer;


  @override
  void initState() {
    super.initState();
    _auth.currentUser!.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _auth.currentUser?.reload();
      if(_auth.currentUser!.emailVerified == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthGate(),));
      }
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Your Email')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('A verification email has been sent to your email address.'),
            SizedBox(height: 20),
            ElevatedButton(
             onPressed: () {
               _auth.currentUser?.sendEmailVerification();
             },
              child: Text('Resend Verification Email'),
            ),
          ],
        ),
      ),
    );
  }
}

  
