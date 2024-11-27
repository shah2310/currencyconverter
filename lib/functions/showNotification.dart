import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
  User? user = FirebaseAuth.instance.currentUser;

Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    "Timestamp.now()", // Channel ID
    'Rate Alerts',         // Channel Name
    channelDescription: 'Notifications for rate alerts',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,   
    title,  
    body,   
    notificationDetails,
  );
}

Future<void> checkExchangeRate(double targetRate, String baseCurrency, String convertCurrency) async {
  try {
    final response = await http.get(
      Uri.parse('https://api.exchangerate-api.com/v4/latest/$baseCurrency'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final currentRate = data['rates'][convertCurrency];
print("object dahsdlkahslkdahsldsa");
      if (true) {
        showNotification(
          'Exchange Rate Alert!',
          '1 $baseCurrency = $currentRate $convertCurrency, which meets your alert condition!',
        );
      }
    } else {
      print('Failed to fetch exchange rates');
    }
  } catch (e) {
    print('Error fetching exchange rate: $e');
  }
}

