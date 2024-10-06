import 'package:college_project/donatepage/donatepage.dart';
import 'package:college_project/Homepage/homepage.dart';
import 'package:college_project/Profile/profiletile/profiepage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  
  MainPage({super.key,});
  
  

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int page = 0;
//  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetlist = [
      Homepage(),

      Donatepage(showbackbutton: false,onpressed: () {
        Navigator.maybePop(context);
      },),
      ProfilePage(onpressed: (){},
      height: false,
      ),
      
    ];
    return Scaffold(
      backgroundColor: Color(0xff247D7F),
      bottomNavigationBar: CurvedNavigationBar(
          index: page,
          color: Color(0xff247D7F),
          backgroundColor: Theme.of(context).colorScheme.secondary,
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
            // Container(
            //   child: Image.asset(
            //     'lib/images/donate.png',
            //     height: 28,
            //     color: Theme.of(context).colorScheme.primary,
            //   ),
            // ),
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
