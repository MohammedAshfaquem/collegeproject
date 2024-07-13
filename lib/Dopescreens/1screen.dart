import 'package:flutter/material.dart';

class firstscreen extends StatelessWidget {
  const firstscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
             height: 800,
             bottom: -270,
             right: -300,
              child: Image.asset(
                  "lib/images/sammy-line-cook-preparing-ingredients-for-a-recipe.png",height: 100,))
        ],
      ),
    );
  }
}
