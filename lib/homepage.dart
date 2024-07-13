import 'package:college_project/doantecontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key,required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Consumer<Donatecontroler>(

      builder: (context, value, child) => Scaffold(
        backgroundColor:Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40,top: 30),
              child: Container(
                child: Row(
                  children: [
                   ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                     child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                      height: 60,
                      width: 60,
                      child: Image.asset("lib/images/images.png"),
                     ),
                   ),
                   SizedBox(width: 20,),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xff247D7F)),),
                        Text("adress",style: TextStyle(color: Colors.grey),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}