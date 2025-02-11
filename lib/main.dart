import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_project/bg.dart';
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
import 'package:workmanager/workmanager.dart';

// Global Key for Navigation
final navigatorkey = GlobalKey<NavigatorState>();
bool isshow = true;

// ✅ WorkManager Background Task
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == "dailyTask") {
      await Firebase.initializeApp();
      await deleteNotesCollection();
    }
    return Future.value(true);
  });
}

// ✅ Function to Delete All Documents in the "notes" Collection
Future<void> deleteNotesCollection() async {
  try {
    var collection = FirebaseFirestore.instance.collection('notes');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    print("✅ All documents in 'notes' collection deleted successfully!");
  } catch (e) {
    print("❌ Error deleting notes collection: $e");
  }
}

// Firebase Background Message Handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize WorkManager BEFORE runApp()
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  // ✅ Register Periodic Task to Run at 4:00 PM
  await Workmanager().registerPeriodicTask(
    'dailyTask',
    'dailyTask',
    frequency: Duration(hours: 24), // Runs every 24 hours
    initialDelay: getDelayUntilNext4PM(), // Delay until next 4:00 PM
    existingWorkPolicy: ExistingWorkPolicy.replace,
  );

  final pref = await SharedPreferences.getInstance();
  isshow = pref.getBool("ON_BOARDING") ?? true;
  await Firebase.initializeApp();
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

// ✅ Function to Calculate Delay Until Next 4:00 PM
Duration getDelayUntilNext4PM() {
  DateTime now = DateTime.now();
  DateTime next4PM = DateTime(now.year, now.month, now.day, 16, 00, 0); // 4:00 PM

  if (now.isAfter(next4PM)) {
    next4PM = next4PM.add(Duration(days: 1)); // Schedule for tomorrow if already past 4 PM
  }

  return next4PM.difference(now);
}
