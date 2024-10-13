import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  int _quantity = 1;
   int get quantity => _quantity;
  void increment() {
    _quantity++;
     print(quantity);
    notifyListeners();
  }

  void decrement() {
    if (quantity > 1) {
      _quantity--;
      print(quantity);
      notifyListeners();
    }
    notifyListeners();
  }
  void reset() {
    _quantity = 1;
    notifyListeners();
  }
  
    set quantity(int value) {
    _quantity = value;
    notifyListeners(); // Notify listeners to update the UI
  }
}
