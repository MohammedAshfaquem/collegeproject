import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:college_project/Profile/Editsprofile/editprofilemodel.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key, required this.username}) : super(key: key);
  final Future<String> username;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController fullnameController;
  late TextEditingController emailController;
  late TextEditingController cnnoController;
  late TextEditingController passwordcontroller;

  Future<String> getUsername() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      var data = userDoc.data() as Map<String, dynamic>;
      return data['name'] as String;
    } else {
      return "No user";
    }
  }
  Future<String> getEmail() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      var data = userDoc.data() as Map<String, dynamic>;
      return data['email'] as String;
    } else {
      return "No user";
    }
  }
  Future<String> getPassword() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      var data = userDoc.data() as Map<String, dynamic>;
      return data['password'] as String;
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

  Future<void> _setemail() async {
    try {
      String username = await getEmail();
      emailController.text = username; // Set the text of the controller
    } catch (e) {
      print("Error: $e");
    }
  }
  Future<void> _setpasssword() async {
    try {
      String username = await getPassword();
      passwordcontroller.text = username; // Set the text of the controller
    } catch (e) {
      print("Error: $e");
    }
  }

  bool _isloading = true;
  
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fullnameController = TextEditingController();
    emailController = TextEditingController();
    cnnoController = TextEditingController();
    passwordcontroller = TextEditingController();
    _setUsername();
    _setemail();
  }

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    cnnoController.dispose();
    passwordcontroller.dispose();

    super.dispose();
  }

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
                    Provider.of<ImgController>(context, listen: false)
                        .imagepickgallery();
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
                            Image.asset('lib/images/gallery.png', height: 50.h),
                            Text("Choose image",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(width: 70),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Provider.of<ImgController>(context, listen: false)
                        .imagepickcamera();
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
                        Image.asset('lib/images/camerapick.png', height: 50.h),
                        Text("Take photo",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600)),
                        SizedBox(width: 90),
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

  @override
  Widget build(BuildContext context) {
    final imagcontroller = Provider.of<ImgController>(context);

    return WillPopScope(
      onWillPop: () async {
        imagcontroller.clearImageCache();
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              imagcontroller.clearImageCache();
              Navigator.maybePop(context);
            },
            icon: Icon(LineAwesomeIcons.angle_left_solid,
                color: Theme.of(context).colorScheme.primary),
          ),
          title: Text('Edit Profile',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: Theme.of(context).colorScheme.primary)),
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
                    FutureBuilder(
                      future: getimage(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, right: 18),
                              child: Container(
                                height: 150,
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100).w,
                                  child: CachedNetworkImage(
                                    errorWidget: (context, url, error) {
                                      return Center(
                                          child: Container(
                                              child: snapshot.hasData
                                                  ? snapshot.data
                                                  : Image.asset(
                                                      "lib/images/avtar.avif")));
                                    },
                                    placeholder: (context, url) => Container(
                                        height: 50.h,
                                        width: 50.h,
                                        child: CircularProgressIndicator()),
                                    imageUrl:
                                        imagcontroller.imageurl.toString(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            height: 150,
                            width: 150,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  "lib/images/avtar.avif",
                                )),
                          );
                        }
                      },
                    ),
                    Positioned(
                      right: 35,
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
                  SizedBox(height: 30),
                  Center(
                      child: Text(
                    "Share a Little bit about Yorself",
                    style: GoogleFonts.poppins(color: Colors.grey.shade600),
                  )),
                  SizedBox(height: 30),
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
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
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
                            color: const Color.fromARGB(255, 255, 0,
                                0)), // When the field is not focused
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color:
                                Colors.grey), // When the field is not focused
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    obscureText: false,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 14, 14))),
                      focusColor: Theme.of(context).colorScheme.primary,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
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
                            color: const Color.fromARGB(255, 255, 0,
                                0)), // When the field is not focused
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color:
                                Colors.grey), // When the field is not focused
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    obscureText: false,
                    controller: cnnoController,
                    decoration: InputDecoration(
                      labelText: "Phone NO",
                      labelStyle: TextStyle(color: Colors.black),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 14, 14))),
                      focusColor: Theme.of(context).colorScheme.primary,
                      prefixIcon: Icon(
                        Icons.call_end_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
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
                            color: const Color.fromARGB(255, 255, 0,
                                0)), // When the field is not focused
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color:
                                Colors.grey), // When the field is not focused
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    obscureText: false,
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 14, 14))),
                      focusColor: Theme.of(context).colorScheme.primary,
                      prefixIcon: Icon(
                        Icons.password,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
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
                            color: const Color.fromARGB(255, 255, 0,
                                0)), // When the field is not focused
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color:
                                Colors.grey), // When the field is not focused
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  GestureDetector(
                    onTap: () {
                      imagcontroller.updateImage();
                      imagcontroller
                          .updateusername(fullnameController.text.toString());
                          
                      Navigator.pop(context);

                      // Add functionality to edit profile here
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff247D7F),
                          borderRadius: BorderRadius.circular(15)),
                      height: 65,
                      width: 400,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LineAwesomeIcons.cloud_upload_alt_solid,color: Colors.white,),
                            SizedBox(width:10,),
                            Text(
                              'Update',

                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17),
                            ),
                          ],
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
