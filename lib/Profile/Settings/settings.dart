import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Profile/PasswordReset/passreset.dart';
import 'package:college_project/Profile/Settings/about_page.dart';
import 'package:college_project/Profile/Settings/faq_page.dart';
import 'package:college_project/Profile/Settings/feedback_page.dart';
import 'package:college_project/Profile/Settings/supportpage.dart';
import 'package:college_project/Profile/profiletile/profiletile.dart';
import 'package:college_project/auth/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to delete user data, donations, and account
  Future<void> _deleteUser() async {
    User? currentUser = _auth.currentUser;

    try {
      if (currentUser != null) {
        // Step 1: Delete the user's donations from the donations collection
        await _deleteUserDonations(currentUser.uid);

        // Step 2: Delete the user's complaints from the feedback collection
        await _deleteUserComplaints(currentUser.uid);

        // Step 3: Delete the user data from Firestore (users collection)
        await _firestore.collection('users').doc(currentUser.uid).delete();
        print("User data deleted from Firestore.");

        // Step 4: Re-authenticate the user via Google Sign-In
        await _reauthenticateAndDelete(currentUser);

        // Step 5: Delete the user from Firebase Authentication (Google sign-in)
        await currentUser.delete(); // This deletes the user's account
        print("User account deleted from Firebase Authentication.");

        // Redirect to the login screen after deletion
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthGate(),
            )); // Adjust as per your app's navigation
      }
    } catch (e) {
      print("Error deleting user: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting user: $e')),
      );
    }
  }

  // Function to delete the user's donations from Firestore
  Future<void> _deleteUserDonations(String userId) async {
    try {
      // Query the donations collection where the 'userId' field matches the current user's UID
      var donationsSnapshot = await _firestore
          .collection('notes')
          .where('uid', isEqualTo: userId)
          .get();

      // Delete each donation document associated with the user
      for (var doc in donationsSnapshot.docs) {
        await doc.reference.delete();
        print("Deleted donation with ID: ${doc.id}");
      }
    } catch (e) {
      print("Error deleting donations: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting donations: $e')),
      );
    }
  }

  Future<void> _deleteUserComplaints(String userId) async {
    try {
      // Query the donations collection where the 'userId' field matches the current user's UID
      var donationsSnapshot = await _firestore
          .collection('feedback')
          .where('uid', isEqualTo: userId)
          .get();

      // Delete each donation document associated with the user
      for (var doc in donationsSnapshot.docs) {
        await doc.reference.delete();
        print("Deleted complaint with ID: ${doc.id}");
      }
    } catch (e) {
      print("Error deleting complaint: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting complaints: $e')),
      );
    }
  }

  // Re-authenticate the user if necessary (required if the session is old)
  Future<void> _reauthenticateAndDelete(User user) async {
    try {
      // Re-authenticate the user via Google Sign-In
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Re-authenticate the user
      await user.reauthenticateWithCredential(credential);
      print("Re-authenticated successfully.");
    } catch (e) {
      print("Error during reauthentication: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Re-authentication failed: $e')),
      );
      throw e; // Propagate the error to be handled in the delete method
    }
  }

  double _rating = 3.0; // Default rating

  // Show rating dialog
  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Rate Your Experience',
            style: TextStyle(color: Colors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'How would you rate your experience?',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 16.0),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40.0,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) {
                  return Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Color(0xff247D7F)),
              onPressed: () {
                // Submit the rating
                Navigator.of(context).pop(); // Close dialog
                _showSubmitMessage(context); // Show the submit message
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Show a confirmation message after submission
  void _showSubmitMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Rating Submitted',
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
              'Thank you for your feedback! Your rating: $_rating stars',
              style: TextStyle(color: Colors.black)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff247D7F),
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProfilePageTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SupportPage(),
                ),
              );
            },
            text: "Help & Support",
            colors: Theme.of(context).colorScheme.surface,
            icon: Icons.headphones,
          ),
          ProfilePageTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComplaintPage(),
                ),
              );
            },
            text: "Report  Bug",
            colors: Theme.of(context).colorScheme.surface,
            icon: Icons.bug_report,
          ),
          ProfilePageTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FAQsPage(),
                ),
              );
            },
            text: "FAQS",
            colors: Theme.of(context).colorScheme.surface,
            icon: Icons.question_answer,
          ),
          ProfilePageTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PassResetPage(),
                ),
              );
            },
            text: "Reset Password",
            colors: Theme.of(context).colorScheme.surface,
            icon: Icons.lock_open,
          ),
          ProfilePageTile(
            onTap: () {
              _showRatingDialog(context);
            },
            text: "Rating",
            colors: Theme.of(context).colorScheme.surface,
            icon: Icons.star,
          ),
          ProfilePageTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ),
              );
            },
            text: "About",
            colors: Theme.of(context).colorScheme.surface,
            icon: Icons.info,
          ),
          ProfilePageTile(
            onTap: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.warning,
                title: 'Do you want to delete your account?',
                confirmBtnText: 'Yes',
                cancelBtnText: 'No',
                showCancelBtn: true,
                confirmBtnColor: Colors.red,
                onCancelBtnTap: () => Navigator.pop(context),
                onConfirmBtnTap: _deleteUser,
              );
            },
            text: "Delete Account",
            colors: Theme.of(context).colorScheme.surface,
            icon: Icons.delete,
          ),
        ],
      ),
    );
  }
}
