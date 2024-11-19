import 'package:bookshop/firebase_options.dart';
import 'package:bookshop/views/ExchangeRatesScreen.dart';
import 'package:bookshop/views/LoginScreen.dart';
import 'package:bookshop/views/SignupScreen.dart';
import 'package:bookshop/views/SplashScreen.dart';
import 'package:bookshop/widgets/AuthWrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
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
