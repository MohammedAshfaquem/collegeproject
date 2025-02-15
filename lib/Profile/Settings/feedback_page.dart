import 'package:college_project/Profile/Settings/complaintrack.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ComplaintPage extends StatefulWidget {
  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _complaintController = TextEditingController();
  var now = DateTime.now();

  // Add a new complaint to Firestore
  Future<void> _submitComplaint(String complaintText) async {
    final CollectionReference feedbackRef =
        FirebaseFirestore.instance.collection('feedback');

    final user = FirebaseAuth.instance.currentUser;
    int newIndex = 1; // Default index if no complaints exist
    try {
      QuerySnapshot snapshot =
          await feedbackRef.orderBy('indexID', descending: true).limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        newIndex = (snapshot.docs.first['indexID'] as int) + 1;
      }
    } catch (e) {
      print("Error fetching latest index: $e");
    }

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('You need to be logged in to submit complaints.')),
      );
      return;
    }

    await _firestore.collection('feedback').add({
      'uid': user.uid,
      'name': user.displayName,
      'complaint': complaintText,
      'status': 'Pending',
      'timestamp': DateFormat('yyyy-MM-dd').format(now),
      'indexID': newIndex
    });

    _complaintController.clear();
    // Navigator.pop(context);
  }

  // Show dialog to add a new complaint
  void _showComplaintDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Submit your Complaint',
          style:
              TextStyle(color: Color(0xff247D7F), fontWeight: FontWeight.bold),
        ),
        content: TextField(
          style: TextStyle(color: Colors.black),
          controller: _complaintController,
          maxLines: 4,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.black),
            ),
            hintText: 'Enter your complaint here...',
            hintStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Color(0xff247D7F),
          //   ),
          //   onPressed: () {
          //     if (_complaintController.text.trim().isNotEmpty) {
          //       _submitComplaint(_complaintController.text.trim());
          //         IconSnackBar.show(context,
          //           duration: Duration(seconds: 3),
          //           backgroundColor: Colors.green,
          //           label: 'Complaint succussfully',
          //           snackBarType: SnackBarType.alert);

          //     } else {
          //       IconSnackBar.show(context,
          //           duration: Duration(seconds: 3),
          //           backgroundColor: Colors.red,
          //           label: 'Complaint cannot be empty.',
          //           snackBarType: SnackBarType.alert);
          //     }
          //   },
          //   child: Text(
          //     'Submit',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff247D7F),
        centerTitle: true,
        title: Text(
          "Complaints",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Center(child: Lottie.asset("lib/Animations/reportbug.json",height: 300)),
              Text(
                "Submit Your Complaint",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Please describe your issue in detail.We will adress it promptly",
                  style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 30,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                controller: _complaintController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: 'Describe your complaint',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (_complaintController.text.trim().isNotEmpty) {
                    _submitComplaint(_complaintController.text.trim());
                    IconSnackBar.show(context,
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.green,
                        label: 'Complaint succefully',
                        snackBarType: SnackBarType.alert);
                  } else {
                    IconSnackBar.show(context,
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                        label: 'Complaint cannot be empty.',
                        snackBarType: SnackBarType.alert);
                  }
                },
                child: Container(
                    height: 50,
                    width: 400,
                    decoration: BoxDecoration(
                        color: Color(0xff247D7F),
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                      child: Text(
                        "Submit complaint",
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Complaint_track(),
                    )),
                child: Text(
                  "Track Your Complaints",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              )),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xff247D7F),
      //   onPressed: _showComplaintDialog,
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
