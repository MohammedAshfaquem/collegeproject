import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 200,
              left: 100,
              child: Image.asset(
                "lib/images/epidemiology.png",
                height: 200,
              )),
          Positioned(
            bottom: 0,
            child: Container(
              height: 280,
              width: 393,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("TOGETHER \nWE'LL CREATE ",style: TextStyle(color: Colors.white,fontSize: 25),),
                  Text("   A HUNGER FREE \n   WORLD",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold))
                ],
              ),
              color: Color(0xff247D7F),
            ),
          )
        ],
      ),
    );
  }
}
