import 'package:bookshop/views/LoginScreen.dart';
import 'package:flutter/material.dart';

void main() {  
  runApp(MyBankApp());  
}  

class MyBankApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      title: 'MyBank',  
      theme: ThemeData(  
        primarySwatch: Colors.blue,  
      ),  
      home: LoginScreen(),  
    );  
  }  
}  