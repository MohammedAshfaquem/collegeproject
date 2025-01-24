import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintPage extends StatefulWidget {
  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _complaintController = TextEditingController();

  // Add a new complaint to Firestore
  Future<void> _submitComplaint(String complaintText) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('You need to be logged in to submit complaints.')),
      );
      return;
    }

    await _firestore.collection('feedback').add({
      'uid': user.uid,
      'complaint': complaintText,
      'status': 'Pending',
      'timestamp': FieldValue.serverTimestamp(),
    });

    _complaintController.clear();
    Navigator.pop(context);
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff247D7F),
            ),
            onPressed: () {
              if (_complaintController.text.trim().isNotEmpty) {
                _submitComplaint(_complaintController.text.trim());
              } else {
                
                IconSnackBar.show(context,
                 duration: Duration(seconds: 3),
                 backgroundColor: Colors.red,
                    label: 'Complaint cannot be empty.',
                    snackBarType: SnackBarType.alert);              
              }
            },
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
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
          "Feedback",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('feedback')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
              'No complaints yet.',
              style: TextStyle(color: Colors.black),
            ));
          }

          final complaints = snapshot.data!.docs;

          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints[index];
              final isCurrentUser =
                  complaint['uid'] == FirebaseAuth.instance.currentUser?.uid;

              return ListTile(
                title: Text(
                  complaint['complaint'],
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  'Status: ${complaint['status']}',
                  style: TextStyle(
                    color: complaint['status'] == 'Pending'
                        ? Colors.orange
                        : Colors.green,
                  ),
                ),
                trailing: isCurrentUser
                    ? null
                    : Text(
                        'By Admin',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.black),
                      ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff247D7F),
        onPressed: _showComplaintDialog,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
