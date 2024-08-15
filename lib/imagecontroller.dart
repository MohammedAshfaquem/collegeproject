import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class imgcontroller extends ChangeNotifier {
  File? image;
  File? savedimage;
  final picker = ImagePicker();

  imagefromgallery() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      image = File(PickedFile.path);
      savedimage = image;
    } else {
      print("no image picked");
    }
    notifyListeners();
    //  if (value != null) {
    //    _cropimage(File(value.path));
    // }
  }

  void clearImageCache() {
    savedimage = null;
    notifyListeners();
  }

  imagefromcamera() async {
    final PickedFile = await picker.pickImage(source: ImageSource.camera);

    if (PickedFile != null) {
      image = File(PickedFile.path);
      savedimage = image;
    } else {
      print("no image picked");
    }
    notifyListeners();
  }
}
