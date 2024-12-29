import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetData {
  Future<String> getUsername() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userdoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userdoc.exists) {
      var data = userdoc.data() as Map<String, dynamic>;
      return data['name'] as String;
    } else {
      return "No user";
    }
  }

  Future<String> getemail() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userdoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userdoc.exists) {
      var data = userdoc.data() as Map<String, dynamic>;
      return data['email'] as String;
    } else {
      return "No user";
    }
  }
}
