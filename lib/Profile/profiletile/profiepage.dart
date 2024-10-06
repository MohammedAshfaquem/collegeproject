import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Profile/Editsprofile/editprofilepage.dart';
import 'package:college_project/Profile/MyDonation/my_donations.dart';
import 'package:college_project/Profile/PasswordReset/passreset.dart';
import 'package:college_project/Profile/Supports/supportpage.dart';
import 'package:college_project/auth/auth_gate.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:college_project/theme/themeprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:college_project/Profile/profiletile/profiletile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage(
      {this.showbackbutton = false,
      required this.onpressed,
      this.height = true});
  final bool showbackbutton;
  final VoidCallback onpressed;
  final bool height;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isloading = true;

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

    Future<Widget> getimage() async {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userdoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userdoc.exists) {
        var data = userdoc.data() as Map<String, dynamic>;
        return Skeletonizer(
          enabled: _isloading,
          child: Image.network(
            data['image'] as String,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                Future.microtask(
                  () {
                    if (mounted) {
                      setState(() {
                        _isloading = false;
                      });
                    }
                  },
                );

                return child;
              } else {
                return Container(
                  color: Colors.grey.shade100,
                );
              }
            },
            fit: BoxFit.fill,
          ),
        );
      } else {
        return Image.asset(
          "lib/images/avtar.avif",
          color: Colors.red,
        );
      }
    }

    final imagcontroller = Provider.of<ImgController>(context);
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
                      imagcontroller.imagepickgallery();
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
                      imagcontroller.imagepickcamera();
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
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: widget.onpressed,
          icon: widget.showbackbutton
              ? Icon(
                  LineAwesomeIcons.angle_left_solid,
                  color: Theme.of(context).colorScheme.primary,
                )
              : SizedBox(),
        ),
        title: Text(' My Profile',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 1,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18),
              child: Container(
                height: 130,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white),
                child: Row(
                  children: [
                    FutureBuilder(
                        future: getimage(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return   ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 18),
                                    child: Row(
                                      children: [
                                       
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100).w,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100)
                                                        .w,
                                              ),
                                              height: 100.h,
                                              width: 100.w,
                                              child: snapshot.data),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                          } else {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 18, right: 18),
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset("lib/images/avtar.avif",)),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                            );
                          }
                        }),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            future: getusername(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                );
                              } else {
                                return Skeletonizer(
                                  child: Text(
                                    "no data found",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                );
                              }
                            }),
                        FutureBuilder(
                            future: getemail(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: 160,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    snapshot.data.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.grey.shade700),
                                  ),
                                );
                              } else {
                                return Skeletonizer(
                                  child: Text(
                                    "no data found",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                );
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: widget.height ? 65 : 35),
            ProfilePageModel(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(username:getusername(),),
                  ),
                );
              },
              text: "Edit Profile",
              colors: Theme.of(context).colorScheme.surface,
              icon: Icons.person,
            ),
            ProfilePageModel(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyDonations(),
                  ),
                );
              },
              text: "My Donations",
              colors: Theme.of(context).colorScheme.surface,
              icon: Icons.call,
            ),
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
                      borderRadius: BorderRadius.circular(15)),
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
                  title: Text("Theme",
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 17)),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthGate(),
                      ),
                    );
                  },
                );
              },
              text: "Log Out",
              icon: Icons.logout,
              colors: Colors.red,
              listtilecolor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
