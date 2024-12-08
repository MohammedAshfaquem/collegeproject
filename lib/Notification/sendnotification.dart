import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

Future<void> sendTopicNotificationv2(String course) async {
  // Load the service account key
  final serviceAccountKey = await rootBundle.loadString(
      'Assets/college-49a8d-firebase-adminsdk-tpksv-c3f91bf056.json');
  final credentials =
      ServiceAccountCredentials.fromJson(json.decode(serviceAccountKey));

  final scopes = ['https://www.googleapis.com/auth/cloud-platform'];

  // Get an authenticated HTTP client
  final client = await clientViaServiceAccount(credentials, scopes);

  final accessToken = (await client.credentials).accessToken.data;

  print("AccessToken: $accessToken");

  final Map<String, dynamic> notification = {
    'title': 'New donation Here',
    'body': '$course  Student added food here',
  };

  final Map<String, dynamic> message = {
    'topic': 'Ashfaque',
    'notification': notification,
  };
  final String url =
      'https://fcm.googleapis.com/v1/projects/college-49a8d/messages:send';

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(<String, dynamic>{
      'message': message,
    }),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification: ${response.statusCode}');
    print('Response: ${response.body}');
  }

  client.close();
}
