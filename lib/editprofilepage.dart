import 'package:college_project/donatepage/donatecontroller.dart';
import 'package:college_project/listilemodel.dart';
import 'package:college_project/profiepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class editProfile extends StatelessWidget {
  var fullname;
  var email;
  editProfile({super.key, required this.fullname, required this.email});

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final fullnameedit = TextEditingController();
    final emailedit = TextEditingController();
    final phonenoedit = TextEditingController();
    final passwordedit = TextEditingController();
    final controller = Provider.of<Donatecontroler>(listen: false, context);
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.surface,
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
          title: Text(
            ' Edit Profile',
            style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1,color:Theme.of(context).colorScheme.primary,),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset("lib/images/avtar.avif")),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    
                    validator: (value) =>
                        value!.isEmpty ? 'please enter your name' : null,
                    controller: fullnameedit,
                    decoration: InputDecoration(
                      focusColor:Theme.of(context).colorScheme.primary,
                      
                      prefixIcon: Icon(Icons.person_outline_rounded,color: Theme.of(context).colorScheme.primary,),
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15).w,
                        borderSide: BorderSide(
                            color:Theme.of(context).colorScheme.primary,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'please enter your email' : null,
                    controller: emailedit,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email,color: Theme.of(context).colorScheme.primary,),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15).w,
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 144, 51, 51)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) =>
                        value!.isEmpty || value.length <10? 'please enter valid phone ' : null,
                    controller: phonenoedit,
                    decoration: InputDecoration(
                      
                      prefixIcon: Icon(Icons.phone,color: Theme.of(context).colorScheme.primary,),
                      hintText: 'Phone no',
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(15).w,
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 144, 51, 51)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                     validator: (value) =>
                        value!.isEmpty ? 'please enter your password' : null,
                    controller: passwordedit,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_rounded,color: Theme.of(context).colorScheme.primary,),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15).w,
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 144, 51, 51)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                     if(_formkey.currentState!.validate()){
                       Navigator.maybePop(
                        context,
                      );
                      controller.editprofile(fullnameedit.text, emailedit.text);
                     }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff247D7F),
                          borderRadius: BorderRadius.circular(30)),
                      height: 50,
                      width: 200,
                      child: Center(
                          child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 17),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
