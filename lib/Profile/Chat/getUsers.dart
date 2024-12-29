import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUsers {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection("users")
        .where("uid", isNotEqualTo: currentUserUid,)
        .snapshots();
  }
}
