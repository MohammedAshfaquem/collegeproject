import 'package:flutter/material.dart';

class SlideImageController extends ChangeNotifier {
 int _selectedindex = 0;
  int get selectedindex => _selectedindex;

  void  updateindex(int index,){
   _selectedindex = index;
  notifyListeners();
  }
}
