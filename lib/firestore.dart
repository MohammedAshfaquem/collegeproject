import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServivce {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(
      String fname,
      String lname,
      String number,
      String foodname,
      // String category
      String course,
      String option,
      String decsription,
      String image,
      DateTime time) {
    return notes.add({
      'course': course,
      'first name': fname,
      'last name': lname,
      'number': number,
      'food name': foodname,
      // 'category': category,
      'option': option,
      'decsription': decsription,
      'image': image,
      'time': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNotesStream() {
    final notesstream = notes.orderBy('time', descending: true).snapshots();
    return notesstream;
  }
}
