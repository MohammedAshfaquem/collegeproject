import 'package:college_project/category/category_page.dart';
import 'package:college_project/donatepage/donatepage.dart';
import 'package:college_project/Homepage/homepage.dart';
import 'package:college_project/Profile/profiletile/profiepage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class mainpage extends StatefulWidget {
  mainpage({super.key, required this.names});
  final String names;
  

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  int page = 0;
//  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetlist = [
      Homepage(name: widget.names),
      CategoryDonate(cheight: false,),
      Donatepage(showbackbutton: false,onpressed: () {
        Navigator.maybePop(context);
      },),
      Profilepage(),
      
    ];
    return Scaffold(
      backgroundColor: Color(0xff247D7F),
      bottomNavigationBar: CurvedNavigationBar(
          index: page,
          color: Color(0xff247D7F),
          backgroundColor: Theme.of(context).colorScheme.surface,
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
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Container(
              child: Image.asset(
                'lib/images/donate.png',
                height: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Container(
              child: Image.asset(
                'lib/images/find.png',
                height: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Container(
              child: Image.asset(
                'lib/images/user.png',
                height: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ]),
      body: Center(child: widgetlist[page]),
    );
  }
}
