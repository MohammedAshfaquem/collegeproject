import 'package:college_project/Carousalslider2/imagecontroller.dart';
import 'package:college_project/Donatepage/donate_controller.dart';
import 'package:college_project/Notification/notificationHandler.dart';
import 'package:college_project/OnBoardingScreens/Dopescrees.dart';
import 'package:college_project/OnBoardingScreens/dopcontroller.dart';
import 'package:college_project/category/quantitycontroller.dart';
import 'package:college_project/donatepage/donatepage.dart';
import 'package:college_project/editcontroller.dart';
import 'package:college_project/imagecontroller.dart';
import 'package:college_project/auth/auth_gate.dart';
import 'package:college_project/theme/themeprovider.dart';
import 'package:college_project/zegocloud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

final navigatorkey = GlobalKey<NavigatorState>();
bool isshow = true;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  isshow = pref.getBool("ON_BOARDING") ?? true;
  await Firebase.initializeApp();
  Notificationhandler.requestnotification();
  FirebaseMessaging.instance.subscribeToTopic('Ashfaque');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
   ZIMKit().init(
      appID: ZegoCloudConstants.zegocloudAppId,
      appSign: ZegoCloudConstants.zegocloudAppSign
    );
  runApp(
   
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Donate(),
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
        ChangeNotifierProvider(
          create: (context) => QuantityController(),
        ),
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
            'Authpage': (context) => AuthGate()
          },
        ),
      ),
    ),
  );
  FlutterNativeSplash.remove();
}
