import 'package:college_project/Carousalslider2/imagecontroller.dart';
import 'package:college_project/Donatepage/donate_controller.dart';
import 'package:college_project/Donatepage/donatepage.dart';
import 'package:college_project/Dopescreens/dopcontroller.dart';
import 'package:college_project/editcontroller.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:college_project/auth/auth_gate.dart';
import 'package:college_project/service/notiffication.dart';
import 'package:college_project/theme/themeprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
 final navigatorkey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();

  runApp(
    MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (context) => Donate(),),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SlideImageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DopeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImgController(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(412, 824),
        builder: (context, child) => MaterialApp(
            theme: Provider.of<ThemeProvider>(context).themedata,
            debugShowCheckedModeBanner: false,
            home:AuthGate(),
            navigatorKey: navigatorkey,
            routes:{
              '/notifivationscreen':(context) =>     Donatepage(onpressed: (){})      },),
            
      ),
      
    ),
  );
}
