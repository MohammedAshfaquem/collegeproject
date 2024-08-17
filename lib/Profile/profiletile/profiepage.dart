import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Profile/Editsprofile/editprofilepage.dart';
import 'package:college_project/Profile/PasswordReset/passreset.dart';
import 'package:college_project/Profile/Supports/supportpage.dart';
import 'package:college_project/editcontroller.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:college_project/theme/themeprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:college_project/Profile/profiletile/profiletile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage();

  @override
  Widget build(BuildContext context) {
    Future<String> getusername() async {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userdoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userdoc.exists) {
        var data = userdoc.data() as Map<String, dynamic>;
        return data['name'] as String;
      } else {
        return "No user";
      }
    }

    Future<String> getemail() async {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userdoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userdoc.exists) {
        var data = userdoc.data() as Map<String, dynamic>;
        return data['email'] as String;
      } else {
        return "No user";
      }
    }

    final imagcontroller = Provider.of<ImgController>(
      context,
    );
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          ' My Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          
          Center(
            child: Container(
              height: 150,
              width: 150,
              child: Stack(
                children: [
                  Consumer<ImgController>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        decoration: BoxDecoration(
                           border: Border.all(color:Theme.of(context).colorScheme.primary,width: 1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        height: 120,
                        width: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: imagcontroller.savedimage == null
                                ? Image.asset("lib/images/avtar.avif")
                                : Image.file(
                                    value.savedimage!,
                                    fit: BoxFit.fill,
                                  )),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 25,
                    bottom: 25,
                    child: CircleAvatar(
                      radius: 15,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            showimagepicker();
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.surface,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: getusername(),
            builder: (context, snapshot) => Text(
              snapshot.data.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder(
            future: getemail(),
            builder: (context, snapshot) => Text(
              snapshot.data.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SizedBox(height: 35),
          // ProfilePageModel(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => EditProfilePage(),
          //       ),
          //     );
          //   },
          //   text: "My Profile",
          //   colors: Theme.of(context).colorScheme.surface,
          //   icon: Icons.person,
          // ),
          SizedBox(height: 50,),
          ProfilePageModel(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PassResetPage(),
                ),
              );
            },
            text: "Reset Password",
            colors: Theme.of(context).colorScheme.surface,
            icon: Icons.lock,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
            child: ListTile(
                onTap: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                tileColor: const Color(0xff247D7F),
                leading: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      color: Theme.of(context).colorScheme.surface),
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.color_lens,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  "Theme",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 17),
                ),
                trailing: Consumer<ThemeProvider>(
                    builder: (context, value, child) => CupertinoSwitch(
                          trackColor: Theme.of(context).colorScheme.primary,
                          value: value.isselected,
                          onChanged: (newvalue) {
                            value.toggletheme(newvalue);
                          },
                          focusColor: Colors.white,
                        ))),
          ),
          ProfilePageModel(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SupportPage(),
                ),
              );
            },
            text: "Support",
            colors: Theme.of(context).colorScheme.surface,
            icon: Icons.call,
          ),
          ProfilePageModel(
            onTap: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.warning,
                title: 'Do you want to logout?',
                confirmBtnText: 'Yes',
                cancelBtnText: 'No',
                showCancelBtn: true,
                confirmBtnColor: Colors.green,
                headerBackgroundColor: Colors.red.shade400,
                onCancelBtnTap: () => Navigator.pop(context),
                onConfirmBtnTap: () {
                  //
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
              );
            },
            text: "Log Out",
            icon: Icons.logout,
            colors: Colors.red,
            listtilecolor: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
