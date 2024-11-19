import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Settings")),
      body: Center(
        child: Text("Settings Screen"),
      ),
    );
  }
}
