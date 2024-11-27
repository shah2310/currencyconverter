import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void registerServiceWorker() {
  if (FirebaseMessaging.instance.isSupported() as bool) {
    FirebaseMessaging.instance.setAutoInitEnabled(true).then((_) {
      FirebaseMessaging.instance.getToken().then((token) {
        print(token);
      }).catchError((e) {
        print("Error getting token: $e");
      });
    }).catchError((e) {
      print("Error initializing Firebase Messaging: $e");
    });
  }
}

Future<String?> getFcmToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  String? token = await messaging.getToken();
  print("FCM Token: $token");

  return token;
}

Future<void> saveFcmToken(String? userId) async {
  if (userId != null) {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    if (fcmToken != null) {
      await FirebaseFirestore.instance.collection('alerts').doc(userId).set({
        'fcmToken': fcmToken,
      });
      print("User data and FCM token saved to Firestore");

      messaging.onTokenRefresh.listen((newToken) async {
        print("FCM Token refreshed: $newToken");

        await FirebaseFirestore.instance
            .collection('alerts')
            .doc(userId)
            .update({
          'fcmToken': newToken,
        });
      });
    }
  }
}
