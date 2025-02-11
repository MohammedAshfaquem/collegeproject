// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter_foreground_task/flutter_foreground_task.dart';

// void startAlarmService() async {
//   await FlutterForegroundTask.startService(
//     notificationTitle: 'Alarm Running',
//     notificationText: 'Checking time...',
//     callback: alarmCheck,
//   );
// }

// // Function that runs in the background
// @pragma('vm:entry-point')
// void alarmCheck() {
//   Timer.periodic(Duration(minutes: 1), (timer) {
//     DateTime now = DateTime.now();
    
//     if (now.hour == 13 && now.minute == 37) {
//       log("🔔 Alarm Triggered at 12:30 PM!");
//       timer.cancel();
//     }
//   });
// }
