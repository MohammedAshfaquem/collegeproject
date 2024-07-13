import 'package:college_project/Login/lofinpage.dart';
import 'package:college_project/Login/registerpage.dart';
import 'package:flutter/material.dart';

class Secoundscreen extends StatelessWidget {
  const Secoundscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 800,
        child: Stack(
          children: [
           
            Positioned(
              bottom: 420,
              right: 121,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>loginpage(),));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff247D7F), borderRadius: BorderRadius.circular(7)),
                  height: 50,
                  width: 150,
                  child: Center(
                      child: Text(
                    "LOG IN",
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
             Positioned(
              bottom: 350,
              right: 121,
               child: GestureDetector(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>Registerpage(),));
                },
                 child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple[100], borderRadius: BorderRadius.circular(7)),
                  height: 50,
                  width: 150,
                  child: Center(
                      child: Text(
                    "SIGN UP",
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                           ),
               ),
             ),
            Positioned(
              bottom: -50,
              left: -10,
              child: Image.asset(
                  "lib/images/sammy-line-bicycle-courier-delivering-food.png"),
            )
          ],
        ),
      ),
    );
  }
}
