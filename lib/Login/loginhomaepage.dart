import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage1 extends StatefulWidget {
  Homepage1({super.key});

  @override
  State<Homepage1> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage1> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                // ignore: prefer_interpolation_to_compose_strings
                Text("signed as " + user!.email!),
                TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text("Sign Out"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}