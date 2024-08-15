import 'package:college_project/Carousalslider2/imagecontroller.dart';
import 'package:college_project/Carousalslider2/imagecontroller.dart';
import 'package:college_project/Donatepage/donatecontroller.dart';
import 'package:college_project/edit.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:college_project/Profile/Editsprofile/editprofilemodel.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imagcontroller = Provider.of<imgcontroller>(
      context,
    );
    final controller = Provider.of<editcontroller>(
      context,
    );
    TextEditingController fullnameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController cnnoController = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    final _formkey = GlobalKey<FormState>();


    void showimagepicker() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Card(
            semanticContainer: true,
            margin: EdgeInsets.all(25),
            child: Container(
              height: 160,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      imagcontroller.imagefromgallery();
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 70.h,
                          width: 350.w,
                          decoration: BoxDecoration(
                              color: Color(0xff247D7F),
                              borderRadius: BorderRadius.circular(22)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'lib/images/gallery.png',
                                height: 50.h,
                              ),
                              Text(
                                "Choose image",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 70,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      imagcontroller.imagefromcamera();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 70.h,
                      width: 350.w,
                      decoration: BoxDecoration(
                          color: Color(0xff247D7F),
                          borderRadius: BorderRadius.circular(22)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'lib/images/camerapick.png',
                            height: 50.h,
                          ),
                          Text(
                            "Take photo",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 90,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return PopScope(
      onPopInvoked: (didPop) => imagcontroller.clearImageCache(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              imagcontroller.clearImageCache();
              Navigator.maybePop(context);
            },
            icon: Icon(
              LineAwesomeIcons.angle_left_solid,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          title: Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
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
                  Stack(
                    children: [
                      Consumer<imgcontroller>(
                        builder: (context, value, child) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: imagcontroller.savedimage == null
                                  ? Image.asset("lib/images/avtar.avif")
                                  : Image.file(value.savedimage!)),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: 15,
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                showimagepicker();
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  editprofilemodel(
                    hinttext: 'Full Name',
                    errortext: "Please enter your name",
                    controller: fullnameController,
                    icon: Icons.person,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 20),
                  editprofilemodel(
                    hinttext: 'Email',
                    errortext: "Please enter a valid email",
                    controller: emailController,
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  editprofilemodel(
                    hinttext: 'Phone no',
                    errortext: "Please enter a valid phone number",
                    controller:
                        cnnoController, // Placeholder, can be removed if not used
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),
                  editprofilemodel(
                    hinttext: 'Password',
                    errortext: "Please enter your password",
                    controller:
                        passwordcontroller, // Placeholder, can be removed if not used
                    icon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if(_formkey.currentState!.validate()){
                        controller.updatename(fullnameController.text);
                      controller.updateemail(emailController.text);
                      controller.updateimage(imagcontroller.savedimage == null
                          ? imagcontroller.image!
                          : imagcontroller.savedimage!);
                      Navigator.pop(context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff247D7F),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 50,
                      width: 200,
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
