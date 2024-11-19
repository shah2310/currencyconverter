import 'package:bookshop/widgets/CustomHeader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget {
  final TextEditingController rateController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  DateTime now = DateTime.now();
  String timestamp = "${DateTime.now().millisecond}";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomHeader(
        title: 'Create Alert',
        actions: [
          IconButton(
            onPressed: () {
              print(user?.uid);
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Target Exchange Rate (e.g., 300 PKR)"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                double targetRate = double.parse(rateController.text);
                await FirebaseFirestore.instance.collection('alerts').add({
                  'targetRate': targetRate,
                  'currencyPair': 'USD/PKR',
                  'userId': user?.uid,
                  'createdAt': timestamp,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Alert created successfully!')),
                );
              },
              child: Text("Set Alert"),
            ),
          ],
        ),
      ),
    );
  }
}
