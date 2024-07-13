import 'package:college_project/Dopescreens/Dopescrees.dart';
import 'package:college_project/doantecontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => Donatecontroler(),)
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Dopescreens(),
    ), 
    ));
}


