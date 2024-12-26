import 'package:college_project/donatepage/donatepage.dart';
import 'package:college_project/Homepage/homepage.dart';
import 'package:college_project/Profile/profiletile/profiepage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  int page = 0;
  bool isKeyboardVisible = false; // Track keyboard visibility

  void updateNavigationBarVisibility(bool isFocused) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Observe app lifecycle changes
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Clean up observer
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Called whenever there is a change in app dimensions (e.g., keyboard visibility)
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newKeyboardState = bottomInset > 0;

    if (newKeyboardState != isKeyboardVisible) {
      setState(() {
        isKeyboardVisible = newKeyboardState;
      });
    }
  }

//  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetlist = [
      Homepage(),
      Donatepage(
        showbackbutton: false,
        onpressed: () {
          Navigator.maybePop(context);
        },
        onSearchFocusChange: (isFocused) {
          // Update keyboard visibility state manually if needed
          setState(() {
            isKeyboardVisible = isFocused;
          });
        },
      ),
      ProfilePage(
        onpressed: () {},
        height: false,
      )
    ];
    return Scaffold(
      backgroundColor: Color(0xff247D7F),
      bottomNavigationBar: isKeyboardVisible
          ? null
          : CurvedNavigationBar(
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
                      color: Colors.white,
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
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'lib/images/user.png',
                      height: 28,
                      color: Colors.white,
                    ),
                  ),
                ]),
      body: Center(child: widgetlist[page]),
    );
  }
}
