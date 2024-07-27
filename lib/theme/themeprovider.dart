import 'package:college_project/theme/darktheme.dart';
import 'package:flutter/material.dart';

class Themeprovider with ChangeNotifier {
  ThemeData _themdata = lightmode;
  ThemeData get themedata => _themdata;
  late bool theme;
  set themdata(ThemeData themdata) {
    _themdata = themdata;
    notifyListeners();
  }

  void toggletheme() {
    if (_themdata == lightmode) {
      themdata = darkmode;
    } else {
      themdata = lightmode;
    }
  
  }
}
