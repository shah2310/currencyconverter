import 'package:bookshop/colors/Colors.dart';
import 'package:bookshop/services/AuthService.dart';
import 'package:bookshop/services/ExchangeRateService.dart';
import 'package:bookshop/services/firebase_service.dart';
import 'package:bookshop/sharedPreferences/CurrencyPreferences.dart';
import 'package:bookshop/views/LoginScreen.dart';
import 'package:bookshop/widgets/CustomButtom.dart';
import 'package:bookshop/widgets/CustomDropdown.dart';
import 'package:bookshop/widgets/CustomHeader.dart';
import 'package:bookshop/widgets/RateChecker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final ExchangeRateService _exchangeRateService = ExchangeRateService();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final AuthService _authService = AuthService();
  final TextEditingController _baseController =
      TextEditingController(text: '1');
  final TextEditingController _convertController = TextEditingController();

  Map<String, dynamic>? exchangeRates;
  List<String> currencies = [];
  String _baseCurrency = 'USD';
  String? _targetCurrency = 'USD';
  String? _convertCurrency = 'PKR';
  bool isLoading = true;
  final TextEditingController rateController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  DateTime now = DateTime.now();
  String timestamp = "${DateTime.now().millisecond}";

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
    requestNotificationPermissions();
  }

  Future<void> requestNotificationPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User denied permission');
    }
  }

  Future<void> fetchExchangeRates() async {
    setState(() {
      isLoading = true;
    });

    try {
      exchangeRates = await _exchangeRateService.getExchangeRates(
          baseCurrency: _baseCurrency);
      if (exchangeRates != null) {
        currencies = exchangeRates!['rates'].keys.toList();
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch exchange rates: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<DropdownMenuItem<String>> get _currencyItems {
    return currencies.map((currency) {
      return DropdownMenuItem<String>(
        value: currency,
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(
                'https://flagcdn.com/32x24/${currency.toLowerCase().substring(0, 2)}.png',
              ),
            ),
            const SizedBox(width: 8),
            Text(currency),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: 'Create Alert',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "When $_baseCurrency equals $_convertCurrency:",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  CustomDropdown<String>(
                    value: _baseCurrency,
                    items: _currencyItems,
                    readOnly: true,
                    textChange: (newValue) {
                      _baseController.value = TextEditingValue(
                        text: newValue,
                        selection:
                            TextSelection.collapsed(offset: newValue.length),
                      );
                    },
                    onChanged: (String? newValue) async {
                      setState(() {
                        _baseCurrency = newValue!;
                        _targetCurrency = newValue;
                      });
                      await fetchExchangeRates();
                    },
                    textController: _baseController,
                    hint: 'Select a currency',
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown<String>(
                    value: _convertCurrency,
                    items: _currencyItems,
                    textChange: (newValue) {
                      _convertController.value = TextEditingValue(
                        text: newValue,
                        selection:
                            TextSelection.collapsed(offset: newValue.length),
                      );
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        _convertCurrency = newValue;
                      });
                    },
                    textController: _convertController,
                    hint: 'Select a currency',
                  ),
             
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: "Create Alert",
                  onPressed: () async {
                //   double targetRate = double.parse(rateController.text);
                // await FirebaseFirestore.instance.collection('alerts').add({
                //   'targetRate': targetRate,
                //   'currencyPair': 'USD/PKR',
                //   'userId': user?.uid,
                //   'createdAt': timestamp,
                // });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Alert created successfully!')),
                    );

                
                    final FlutterLocalNotificationsPlugin
                        flutterLocalNotificationsPlugin =
                        FlutterLocalNotificationsPlugin();

                    const AndroidNotificationDetails androidDetails =
                        AndroidNotificationDetails(
                      'rate_alerts_channel',
                      'Rate Alerts',
                      channelDescription: 'Notifications for rate alerts',
                      importance: Importance.max,
                      priority: Priority.high,
                      ticker: 'ticker',
                    );

                    const NotificationDetails notificationDetails =
                        NotificationDetails(android: androidDetails);

                    // await flutterLocalNotificationsPlugin.initialize(
                    //   onSelectNotification: onSelectNotification,
                    // );

                    try {
                      await flutterLocalNotificationsPlugin.show(
                        0,
                        "title",
                        "body",
                        notificationDetails,
                      );
                    } catch (e) {
                      print('Error showing notification: $e');
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
