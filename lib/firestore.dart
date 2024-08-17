import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServivce {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(
      String fname,
      String lname,
      String number,
      // File? image,
      // String foodname,
      // String decsription,
      // String category,
      // String option
      // String course,
      ) {
    return notes.add({
      // 'course': course,
      'time': Timestamp.now(),
      'first name': fname,
      'last name': lname,
      'number': number,
      //  'image': image,
      // 'food name': foodname,
      // 'decsription': decsription,
      // 'category': category,
      // 'option': option,
    });
  }

  Stream<QuerySnapshot> getNotesStream() {
    final notesstream = notes.orderBy('time', descending: true).snapshots();
    return notesstream;
  }
}
