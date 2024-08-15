import 'package:college_project/Mainpage/mainpage.dart';
import 'package:college_project/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurreuser() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context)async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await  googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;

    if(result != null){
      Map<String,dynamic> userInfoMap = {
        "email":userDetails!.email,
        "name":userDetails.displayName,
        "imgurl":userDetails.photoURL,
        "id":userDetails.uid
      };
      await DatabaseMethods().addUser(userDetails.uid,userInfoMap).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>mainpage() ,));
      },);
  }
  }
}
