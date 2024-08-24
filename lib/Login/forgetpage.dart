import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
              content: Text(e.message.toString(),style: TextStyle(color: Colors.black),),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: Icon(
            LineAwesomeIcons.angle_left_solid,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0).w,
          child: Column(
            children: [
            
              Image.asset("lib/images//forget_password.png"),
              SizedBox(height: 20,),
               Row(
                mainAxisAlignment:MainAxisAlignment.start ,
                 children: [
                   Text(
                    'Forget Password',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                                 ),
                 ],
               ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Please enter your email address and we'll send you  al link to reset your password",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: resetcontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12).w,
                  ),
                  hintText: "Enter your email",
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12).w,
                    borderSide: const BorderSide(color: Color(0xff247D7F),),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              
              GestureDetector(
                onTap: reset,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black),
                      height: 50,
                      width: 170,
                      child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Reset Password",style: TextStyle(fontSize: 16,fontWeight: 
                          FontWeight.bold),),
                          Icon(Icons.arrow_circle_right_outlined,color: Colors.white,)
                        ],
                      )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}