import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {  
  final String description;  
  final String amount;  

  const TransactionItem({required this.description, required this.amount});  

  @override  
  Widget build(BuildContext context) {  
    return ListTile(  
      title: Text(description),  
      trailing: Text(amount),  
    );  
  }  
}  
