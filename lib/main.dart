import 'package:college_project/Carousalslider2/imagecontroller.dart';
import 'package:college_project/Dopescreens/dopcontroller.dart';
import 'package:college_project/donatepage/donatecontroller.dart';
import 'package:college_project/editcontroller.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:college_project/auth/auth_gate.dart';
import 'package:college_project/theme/themeprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DonateController(),
        ),
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
            home:AuthGate()),
      ),
    ),
  );
}
