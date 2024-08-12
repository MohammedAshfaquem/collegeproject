import 'package:college_project/Homepage/homepage.dart';
import 'package:college_project/Login/lofinpage.dart';
import 'package:college_project/Login/registerpage.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
 builder:(context, snapshot) {
   if(snapshot.hasData){
    return mainpage(names: "");
   }else{
    return loginpage();
   }
 },),
    );
  }
}