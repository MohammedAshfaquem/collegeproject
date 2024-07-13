import 'package:college_project/donate.dart';
import 'package:college_project/donatepage.dart';
import 'package:college_project/homepage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class mainpage extends StatefulWidget {
  mainpage({super.key, required this.names});
  final String names;

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  int page = 0;
  
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetlist = [
    Homepage(name:widget.names),
    Donatepage(),
    donatepage(),
  ];
    return Scaffold(
      backgroundColor: Color(0xff247D7F),
      bottomNavigationBar: CurvedNavigationBar(
          color: Color(0xff247D7F),
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              page = index;
            });
          },
          items: [
            Container(
              child: Image.asset(
                'lib/images/home (1).png',
                height: 28,
              ),
            ),
            Container(
              child: Image.asset(
                'lib/images/user.png',
                height: 28,
              ),
            ),
            Container(
              child: Image.asset(
                'lib/images/donate.png',
                height: 28,
              ),
            ),
          ]),
      body: Center(child: widgetlist[page]),
    );
  }
}
