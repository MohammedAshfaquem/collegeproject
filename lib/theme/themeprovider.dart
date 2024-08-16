import 'package:college_project/theme/darktheme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themdata = lightmode;
  ThemeData get themedata => _themdata;
   bool _theme = true ;
   bool get theme => _theme;
   bool _isselected = false;
   bool get isselected => _isselected;
  set themdata(ThemeData themdata) {
    _themdata = themdata;
    notifyListeners();
  }

  void toggletheme(bool value,) {
    if (_themdata == lightmode) {
    
      themdata = darkmode;
      _isselected =value;
    } else {
      themdata = lightmode;
        _isselected =value;
    }
    notifyListeners();
  
  }
  void changetext(){
    _theme =! _theme;
    notifyListeners();
  }


}
