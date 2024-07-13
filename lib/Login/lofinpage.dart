import 'package:college_project/Login/forgetpage.dart';
import 'package:college_project/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class loginpage extends StatefulWidget {

  const loginpage({super.key,});

  @override
  State<loginpage> createState() => _loginpageState();
}

// ignore: camel_case_types
class _loginpageState extends State<loginpage> {
  final textcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  Future signup() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: textcontroller.text.trim(),
        password: passwordcontroller.text.trim());
  }

  @override
  void dispose() {
    super.dispose();
    textcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              const Icon(
                Icons.android,
                size: 80,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "HELLO AGAIN",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              const Text(
                "Welcome Back,  You've been Missed!",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: textcontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Email",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.deepPurple),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "passwords",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.deepPurple),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>const  Forgetpage(),
                        )),
                    child: const Text(
                      "Forget password?",
                      style: TextStyle(
                          color: Color(0xff247D7F), fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap:() {
                  Navigator.push(context,MaterialPageRoute(builder:(context) => mainpage(names:textcontroller.text),));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff247D7F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 55,
                  width: 390,
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not a memeber?",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}