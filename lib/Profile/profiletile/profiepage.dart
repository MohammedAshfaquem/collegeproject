import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/Profile/Editsprofile/editprofilepage.dart';
import 'package:college_project/Profile/PasswordReset/passreset.dart';
import 'package:college_project/Profile/Supports/supportpage.dart';
import 'package:college_project/editcontroller.dart';
import 'package:college_project/theme/themeprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:college_project/Profile/profiletile/profiletile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage();

  @override
  Widget build(BuildContext context) {
     Future<String> getusername()async{
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot userdoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  if(userdoc.exists){
    var data = userdoc.data() as Map<String, dynamic>;
    return data['name'] as String;

  }else{
    return "No user";
  }
  }
    Future<String> getemail()async{
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot userdoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  if(userdoc.exists){
    var data = userdoc.data() as Map<String, dynamic>;
    return data['email'] as String;

  }else{
    return "No user";
  }
  }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              height: 130,
              width: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Consumer<EditController>(
                    builder: (context, value, child) => value.image != null
                        ? Image.file(
                            value.image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('lib/images/avtar.avif')),
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
          ProfilePageModel(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ),
              );
            },
            text: "My Profile",
            colors: Theme.of(context).colorScheme.surface,
            icon: Icons.person,
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
