import 'package:college_project/Carousalslider2/imagecontroller.dart';
import 'package:college_project/Dopescreens/dopcontroller.dart';
import 'package:college_project/donatepage/donatecontroller.dart';
import 'package:college_project/edit.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:college_project/main_page.dart';
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
          create: (context) => Donatecontroler(),
        ),
        ChangeNotifierProvider(
          create: (context) => Themeprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Slideimagecontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => Dopecontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => editcontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => imgcontroller(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(412, 824),
        builder: (context, child) => MaterialApp(
            theme: Provider.of<Themeprovider>(context).themedata,
            debugShowCheckedModeBanner: false,
            home:AuthGate()),
      ),
    ),
  );
}
