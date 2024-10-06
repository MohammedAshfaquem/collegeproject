import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgController extends ChangeNotifier {
  bool _isLoading = false;
  String? imageurl;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> imagepickcamera() async {
    setLoading(true);
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file == null) {
      setLoading(false);
      return;
    }

    String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirimages = referenceroot.child('images');
    Reference referenceimagetoupload = referenceDirimages.child(uniquefilename);

    try {
      await referenceimagetoupload.putFile(File(file.path));
      imageurl = await referenceimagetoupload.getDownloadURL();
    } catch (e) {
      print("error:$e");
    } finally {
      setLoading(false);
    }
  }

  Future<String> getImage() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    
    if (userDoc.exists) {
      var data = userDoc.data() as Map<String, dynamic>;
      return data['image'] as String;
    } else {
      // Provide a default image URL
      return "lib/images/avatar.avif"; // Change this to a URL if needed
    }
  }

  Future<void> updateImage() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String newImageUrl = imageurl ?? await getImage(); // Await the getImage call

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'image': newImageUrl});

    notifyListeners();
  }
  updateusername(String name) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'name': name});
    notifyListeners();
  }

  Future<void> imagepickgallery() async {
    setLoading(true);
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      setLoading(false);
      return;
    }

    String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirimages = referenceroot.child('images');
    Reference referenceimagetoupload = referenceDirimages.child(uniquefilename);

    try {
      await referenceimagetoupload.putFile(File(file.path));
      imageurl = await referenceimagetoupload.getDownloadURL();
    } catch (e) {
      print("error:$e");
    } finally {
      setLoading(false);
    }
  }

  void clearImageCache() {
    imageurl = null;
    notifyListeners();
  }
}
