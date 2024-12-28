import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Profile/MyDonation/my_donations.dart';
import 'package:college_project/Profile/PasswordReset/passreset.dart';
import 'package:college_project/Profile/Supports/supportpage.dart';
import 'package:college_project/auth/auth_gate.dart';
import 'package:college_project/chatsScreen.dart';
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
  late TextEditingController fullnameController;
  Future<String> getUsername() async {
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

  Future<void> _setUsername() async {
    try {
      String username = await getUsername();
      fullnameController.text = username; // Set the text of the controller
    } catch (e) {
      print("Error: $e");
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
        "lib/images/profile.jpg",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fullnameController = TextEditingController();
    _setUsername();
  }

  @override
  void dispose() {
    fullnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    void showEditPopup() async {
      final imagcontroller = Provider.of<ImgController>(context, listen: false);
      final TextEditingController fullnameController = TextEditingController();

      // Initialize the controller with the current value from your state
      String username = await getUsername();
      fullnameController.text = username; //
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              "Edit Profile",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    FutureBuilder(
                      future: getimage(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              height: 150.h,
                              width: 150.w,
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                errorWidget: (context, url, error) {
                                  return Center(
                                      child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        height: 150.h,
                                        width: 150.w,
                                        child: snapshot.hasData
                                            ? snapshot.data
                                            : Image.asset(
                                                "lib/images/profile.jpg")),
                                  ));
                                },
                                placeholder: (context, url) => Container(
                                    height: 150.h,
                                    width: 150.h,
                                    child: Center(
                                        child: CircularProgressIndicator())),
                                imageUrl: imagcontroller.imageurl.toString(),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            height: 150.h,
                            width: 150.w,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  "lib/images/profile.jpg",
                                )),
                          );
                        }
                      },
                    ),
                    Positioned(
                      right: 15,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 15,
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
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  obscureText: false,
                  controller: fullnameController,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(color: Colors.black),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 14, 14))),
                    focusColor: Theme.of(context).colorScheme.primary,
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    hintStyle:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15).w,
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary), // When the field is focused
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(
                              255, 255, 0, 0)), // When the field is not focused
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Colors.grey), // When the field is not focused
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  imagcontroller.updateImage();
                  imagcontroller
                      .updateusername(fullnameController.text.toString());

                  Navigator.pop(context);
                },
                child: Text("Update"),
              ),
            ],
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
              padding: const EdgeInsets.only(left: 18, right: 18),
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
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 18, right: 18),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100).w,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100).w,
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
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.asset(
                                            "lib/images/profile.jpg",
                                          )),
                                      //
                                    ],
                                  ),
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
                    Container(
                      width: 170.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                              future: getUsername(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.black),
                                  );
                                } else {
                                  return Skeletonizer(
                                    child: Text(
                                      "no data found",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.black,
                      child: IconButton(
                        onPressed: () {
                          //  showimagepicker();\
                          showEditPopup();
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: widget.height ? 65 : 35),
            // ProfilePageModel(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => EditProfilePage(
            //           username: getUsername(),
            //         ),
            //       ),
            //     );
            //   },
            //   text: "Edit Profile",
            //   colors: Theme.of(context).colorScheme.surface,
            //   icon: Icons.person,
            // ),

            ProfilePageModel(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatsScreen()),
                );
              },
              text: "chat page",
              colors: Theme.of(context).colorScheme.surface,
              icon: Icons.chat,
            ),
            SizedBox(
              height: 10.h,
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
            SizedBox(
              height: 10.h,
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
            SizedBox(
              height: 10.h,
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
            SizedBox(
              height: 10.h,
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
            SizedBox(
              height: 10.h,
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
