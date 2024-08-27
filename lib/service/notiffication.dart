import "package:college_project/main.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";

Future<void> handler(RemoteMessage message) async {
  print("Title :${message.notification?.title}");
  print("Body :${message.notification?.body}");
  print("Payload :${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorkey.currentState?.pushNamed(
      '/notifivationscreen',
      arguments: message,
    );
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("   Token:    $fCMToken");
    FirebaseMessaging.onBackgroundMessage(handler);
  }
  Future initPushNotifications()async{
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
        FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

  }
}
