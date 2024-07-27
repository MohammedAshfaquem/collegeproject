import 'package:college_project/Login/forgetpage.dart';
import 'package:college_project/Login/lofinpage.dart';
import 'package:college_project/donatepage/donatecontroller.dart';
import 'package:college_project/editprofilepage.dart';
import 'package:college_project/listilemodel.dart';
import 'package:college_project/mainpage.dart';
import 'package:college_project/myprofilepage.dart';
import 'package:college_project/passreset.dart';
import 'package:college_project/supportpage.dart';
import 'package:college_project/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Profilepage extends StatelessWidget {
  const Profilepage(
      {super.key,
      this.names = 'Ashfaque',
      this.email = 'Ashfaquemvkpadi@gmail.com'});
  final String names;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:Theme.of(context).colorScheme.surface,
        appBar: AppBar(
         automaticallyImplyLeading: false,
          title: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.w700, 
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 1),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  height: 130,
                  width: 130,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset("lib/images/avtar.avif")),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<Donatecontroler>(
              builder: (context, value, child) =>Text(
                value.eeditname,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<Donatecontroler>(
              builder: (context, value, child) =>Text(value.email,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 35,
            ),
            profilepagemodel(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          editProfile(fullname: names, email: email),
                    ));
              },
              text: "My Profile",
              colors:Theme.of(context).colorScheme.surface,
              icon: Icons.person,
            ),
            profilepagemodel(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => passresetpage(),
                    ));
              },
              text: "Reset Password",
                colors: Theme.of(context).colorScheme.surface,
              icon: Icons.lock,
            ),
            profilepagemodel(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => themepage(),
                    ));
              },
              text: "Theme",
              icon: Icons.color_lens,
                              colors: Theme.of(context).colorScheme.surface,

            ),
            profilepagemodel(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => supportPage(),
                    ));
              },
              text: "Support",
                              colors: Theme.of(context).colorScheme.surface,

              icon: Icons.call,
            ),
            profilepagemodel(
              onTap: () {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.warning,
                  title: 'Do you want to logout',
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  showCancelBtn: true,
                  confirmBtnColor: Colors.green,
                  headerBackgroundColor:  Colors.red.shade400,
                  onCancelBtnTap: () => Navigator.pop(context),
                  onConfirmBtnTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => loginpage(),
                    ),
                  ),
                );
              },
              text: "Log Out",
              icon: Icons.logout,
              colors: Colors.red,
              listtilecolor: Colors.grey.shade200,
            ),
          ],
        ));
  }
}
