import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Complaint_track extends StatefulWidget {
  const Complaint_track({super.key});

  @override
  State<Complaint_track> createState() => _Complaint_trackState();
}

class _Complaint_trackState extends State<Complaint_track> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Color(0xff247D7F),
        centerTitle: true,
        title: Text(
          "Track Complaints",
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

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(7)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 14, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Complaint ID:${complaint['indexID'].toString()}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  complaint['timestamp'],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            complaint['complaint'],
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Reply:",
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          Container(
                            width: 110,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: complaint['status'] == 'Pending'
                                    ? Colors.grey.shade700
                                    : Colors.green),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  complaint['status'] == 'Pending'
                                      ? Icons.pending_sharp
                                      : Icons.done,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${complaint['status']}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          // trailing: isCurrentUser
                          //     ? null
                          //     : Text(
                          //         'By Admin',
                          //         style: TextStyle(
                          //             fontStyle: FontStyle.italic, color: Colors.black),
                          //       ),
                        ],
                      ),
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
