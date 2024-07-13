import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgetpage extends StatefulWidget {
 const Forgetpage({super.key});

  @override
  State<Forgetpage> createState() => _ForgetpageState();
}

class _ForgetpageState extends State<Forgetpage> {
  final resetcontroller = TextEditingController();

  @override
  void dispose() {
    resetcontroller.dispose();
    super.dispose();
  }

  Future reset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetcontroller.text.trim());
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Reset link sended to your email"),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: resetcontroller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Enter your email",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Colors.deepPurpleAccent.shade100,
              onPressed: reset,
              child: const Text("Reset Password"),
            )
          ],
        ),
      ),
    );
  }
}