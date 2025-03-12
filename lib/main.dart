import 'dart:async';
import 'package:flutter/material.dart';
import 'package:college_project/Carousal%20Slider/imagecontroller.dart';
import 'package:college_project/Donate/donate_controller.dart';
import 'package:college_project/Notification/notificationHandler.dart';
import 'package:college_project/OnBoardingScreens/onboarding_screens.dart';
import 'package:college_project/OnBoardingScreens/onboarding_controller.dart';
import 'package:college_project/Profile/theme/themeprovider.dart';
import 'package:college_project/Category/quantity_controller.dart';
import 'package:college_project/Donate/available_foods.dart';
import 'package:college_project/Edit%20Image/image_controller.dart';
import 'package:college_project/Auth/auth_gate.dart';
import 'package:college_project/Profile/Chat/zegocloud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// Global Key for Navigation
final navigatorkey = GlobalKey<NavigatorState>();
bool isshow = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final pref = await SharedPreferences.getInstance();
  isshow = pref.getBool("ON_BOARDING") ?? true;

  Notificationhandler.requestnotification();
  FirebaseMessaging.instance.subscribeToTopic('Ashfaque');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  ZIMKit().init(
    appID: ZegoCloudConstants.zegocloudAppId,
    appSign: ZegoCloudConstants.zegocloudAppSign,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Donate()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SlideImageController()),
        ChangeNotifierProvider(create: (context) => OnBoardingController()),
        ChangeNotifierProvider(create: (context) => ImageController()),
        ChangeNotifierProvider(create: (context) => QuantityController()),
      ],
      child: ScreenUtilInit(
        designSize: Size(412, 824),
        builder: (context, child) => MaterialApp(
          theme: Provider.of<ThemeProvider>(context).themedata,
          debugShowCheckedModeBanner: false,
          home: isshow ? Dopescreens() : AuthGate(),
          navigatorKey: navigatorkey,
          routes: {
            '/notifivationscreen': (context) => Donatepage(onpressed: () {}),
            'Authpage': (context) => AuthGate(),
          },
        ),
      ),
    ),
  );
  FlutterNativeSplash.remove();
}

// ✅ Firebase Background Message Handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
