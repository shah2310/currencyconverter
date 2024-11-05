import 'package:bookshop/image/Images.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image.asset(
      ImagesPath.loginImage, // Correct usage of Image.asset
    ));
  }
}
