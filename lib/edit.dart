import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final emailuser = FirebaseAuth.instance.currentUser;
class editcontroller extends ChangeNotifier {
  String _name = 'ashfaque';
  String get name => _name;
  String _email = emailuser!.email!;
  String get email => _email;
  File? image;
  // String get image => _image!;
  File? savedimage;

  void updatename(String name) {
    _name = name;
    notifyListeners();
  }

  void updateemail(String email) {
    _email = email;
    notifyListeners();
  }

  void updateimage(File images) {
    image = images;
    savedimage = images;
    notifyListeners();
  }
}
