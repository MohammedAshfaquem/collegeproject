
import 'package:flutter/material.dart';

class Donatecontroler extends ChangeNotifier{
List<Itemmodel> _itemlist = [];
List<Itemmodel> get itemlist=> _itemlist;


  
  void addtile(Itemmodel itemmodel) {
   itemlist.add(
    itemmodel
   );
  }
   void deleteitem(int removeitem, BuildContext context) {
    _itemlist.removeAt(removeitem);
    notifyListeners();
  }
   
}



class Itemmodel{
  final DateTime date;
  final String username;
  final String itemname;
  final String course;
  final String cntctbo;
  final String descriptiom;

  Itemmodel({required this.date, required this.username, required this.itemname,
   required this.course, required this.cntctbo, required this.descriptiom});
  
}