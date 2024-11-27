import 'package:bookshop/firebase_options.dart';
import 'package:bookshop/functions/showNotification.dart';
import 'package:bookshop/services/firebase_service.dart';
import 'package:bookshop/views/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings(
          '@mipmap/ic_launcher'); // Replace with your app's launcher icon
  const InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
  registerServiceWorker();
}

// FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   print('Message received: ${message.notification?.title}');
// });

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CurrenSee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
