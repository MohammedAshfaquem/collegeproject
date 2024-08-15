import 'dart:io';
import 'package:flutter/material.dart';

class edit extends ChangeNotifier {
  String _name = 'ashfaque';
  String get name => _name;
  String _email = 'Ashfaque@gmail.com';
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
