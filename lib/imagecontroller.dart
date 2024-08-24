import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgController extends ChangeNotifier {
  File? image;
  String? savedimage;
  final picker = ImagePicker();
  String imageurl = '';
  final addimagedb = FirebaseFirestore.instance.collection('users');

   imagepickcamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
    // if (file == null) return;
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirimages = referenceroot.child('images');
    Reference referenceimagetoupload = referenceDirimages.child(uniquefilename);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    
    try {
      await referenceimagetoupload.putFile(File(file!.path));
      imageurl = await referenceimagetoupload.getDownloadURL();
      FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'image':imageurl});
    } catch (e) {
      print("error getting :$e");
    };
  }

  imagepickgallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
    // if (file == null) return;
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirimages = referenceroot.child('images');
    Reference referenceimagetoupload = referenceDirimages.child(uniquefilename);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    
    try {
      await referenceimagetoupload.putFile(File(file!.path));
      imageurl = await referenceimagetoupload.getDownloadURL();
       FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'image': imageurl});
    } catch (e) {
      print("error:$e");
    }
    ;
  }

  void clearImageCache() {
    savedimage = null;
    notifyListeners();
  }

  // imagefromcamera() async {
  //   final PickedFile = await picker.pickImage(source: ImageSource.camera);

  //   if (PickedFile != null) {
  //     image = File(PickedFile.path);
  //     savedimage = image;
  //   } else {
  //     print("no image picked");
  //   }
  //   notifyListeners();
  // }
}
