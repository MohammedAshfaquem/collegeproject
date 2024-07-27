import 'package:college_project/Dopescreens/1screen.dart';
import 'package:college_project/Dopescreens/3screen.dart';
import 'package:college_project/Dopescreens/2screen.dart';
import 'package:college_project/Login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dopescreens extends StatefulWidget {
  const Dopescreens({super.key});

  @override
  State<Dopescreens> createState() => _DopescreensState();
}

class _DopescreensState extends State<Dopescreens> {
  PageController _controller=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
          children: [
            firstscreen(),
            Secound(),
            ThirdScreen(),
          ],
        ),
        Container(
          alignment: Alignment(0, 0.85),
          child: SmoothPageIndicator(controller: _controller, count: 3,))
        ],
      ),
    );
  }
}