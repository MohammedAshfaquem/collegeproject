import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FireStoreService {
  var now = DateTime.now();
        User? user = FirebaseAuth.instance.currentUser;
    String? userimage = FirebaseAuth.instance.currentUser?.photoURL;
        

  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');
  Future<void> addNote(
      String fname,
      String lname,
      String number,
      String foodname,
      String course,
      String option,
      String description,
      String image,
      DateTime time,
      String donationId,
      String quantity
      ) {
    return notes.add({
      'course': course,
      'first name': fname,
      'last name': lname,
      'number': number,
      'food name': foodname,
      // 'category': category,
      'option': option,
      'description': description,
      'image': image,
      'time': DateFormat.jm().format(now),
      'uid':user!.uid,
      "donationid":donationId,
      'quantity':quantity,
      'userimage':userimage,
    });
  }

  Stream<QuerySnapshot> getNotesStream() {
    final notesstream = notes.orderBy('time', descending: true).snapshots();
    return notesstream;
  }
}
