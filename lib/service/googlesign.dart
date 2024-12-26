import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Mainpage/mainpage.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:college_project/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleSignin {
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  getCurreuser() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final image = Provider.of<ImgController>(context, listen: false);
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;

    if (userDetails != null) {
      // Fetch the user document from Firebase
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userDetails.uid)
          .get();

      // Check if user data exists in Firebase
      if (userDoc.exists) {
        // User exists, use the stored image URL from Firebase
        final updatedProfilePhotoUrl = userDoc.data()?['image'];
        final updatedMyDonations = userDoc.data()?['mydonations'];

        // Optionally update the ImgController with the stored image URL
        image.imageurl = updatedProfilePhotoUrl;
      } else {
        // User does not exist, create a new document with initial data
        Map<String, dynamic> userInfoMap = {
          "email": userDetails.email,
          "name": userDetails.displayName,
          "id": userDetails.uid,
          "image": userDetails.photoURL,
        };

        await DataBaseMethods().addUser(userDetails.uid, userInfoMap);
      }

      // Navigate to the main page after sign-in
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
  }
}
