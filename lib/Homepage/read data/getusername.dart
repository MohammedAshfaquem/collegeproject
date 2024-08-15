import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Getusername extends StatelessWidget {

  final String documentId;
   Getusername({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference User = FirebaseFirestore.instance.collection('User');
        return FutureBuilder<DocumentSnapshot>(
          future:  User.doc(documentId).get(),
         builder:(context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
            return Text('${data['name']}',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp,
                                color: Color(0xff247D7F)),);
           }
           return Text("Loading");
        },);
  }
}