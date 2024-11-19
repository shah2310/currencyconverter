import 'package:bookshop/views/ExchangeRatesScreen.dart';
import 'package:bookshop/views/HomeScreen.dart';
import 'package:bookshop/views/LoginScreen.dart';
import 'package:bookshop/views/SignupScreen.dart';
import 'package:bookshop/widgets/BottomNavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ExchangeRatesScreen();
          } else {
            return LoginScreen();
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}