import 'package:flutter/material.dart';

class imagecontroller extends ChangeNotifier {
 int _selectedindex = 0;
  int get selectedindex => _selectedindex;

  void  updateindex(int index,){
   _selectedindex = index;
   notifyListeners();
  }
}
