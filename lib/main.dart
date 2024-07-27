import 'package:college_project/Dopescreens/Dopescrees.dart';
import 'package:college_project/category/category_page.dart';
import 'package:college_project/category/categorydetailsapge.dart';
import 'package:college_project/donatepage/donatecontroller.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:college_project/mainpage.dart';
import 'package:college_project/theme/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
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
          create: (context) => imagecontroller(),
        )
      ],
      child: ScreenUtilInit(
        designSize: Size(412, 824),
        builder: (context, child) => MaterialApp(
            theme: Provider.of<Themeprovider>(context).themedata,
            debugShowCheckedModeBanner: false,
            home: Dopescreens()),
      ),
    ),
  );
}
