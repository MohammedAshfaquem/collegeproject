import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  Future addUser(String userId,Map<String ,dynamic> userInfoMap){
    return FirebaseFirestore.instance.collection("users").doc(userId).set(userInfoMap);
  }
}