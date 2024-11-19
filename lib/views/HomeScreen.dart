import 'package:bookshop/services/AuthService.dart';
import 'package:bookshop/views/SignupScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  final AuthService _authService = AuthService();

  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () async {
            bool confirmLogout = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Logout'),
                content: Text('Are you sure you want to log out?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Logout'),
                  ),
                ],
              ),
            );

            if (confirmLogout) {
              await _authService.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Signupscreen()),
                (route) => false,
              );
            }
          },
          icon: const Icon(Icons.logout),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Center(
        child: Text("Welcome to CurrenSee!"),
      ),
    );
  }
}
