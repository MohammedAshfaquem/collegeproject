import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FireStoreServivce {
  var now = DateTime.now();
  final CollectionReference mydonation =
      FirebaseFirestore.instance.collection('mydonations');
  Future<void> addmydonation(
      String fname,
      String lname,
      String number,
      String foodname,
      // String category
      String course,
      String option,
      String decsription,
      String image,
      DateTime time,
      String donationId,
      String quantity,
      
      ) {
    return mydonation.add({
      'course': course,
      'first name': fname,
      'last name': lname,
      'number': number,
      'food name': foodname,
      // 'category': category,
      'option': option,
      'decsription': decsription,
      'image': image,
      'time': DateFormat.jm().format(now),
      "donationid":donationId,
      "quantity":quantity,
      
    });
  }
  Future<void> deletenote(String docId){
  return mydonation.doc(docId).delete();
  }

  Stream<QuerySnapshot> getNotesStream() {
    final notesstream = mydonation.orderBy('time', descending: true).snapshots();
    return notesstream;
  }
}
