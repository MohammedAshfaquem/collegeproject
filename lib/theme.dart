import 'package:college_project/theme/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class themepage extends StatelessWidget {
   themepage({super.key,this.showtheme = false});
  bool showtheme;
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: 
      Center(child: TextButton(onPressed: (){
        
        Provider.of<Themeprovider>(context,listen: false).toggletheme();
        Navigator.maybePop(context);
        
      }, child:showtheme?Text("Light"):Text("Dark"))),
    );
  }
}