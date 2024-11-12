import 'package:flutter/material.dart';

class CurrencyRateItem extends StatelessWidget {  
  final String currency;  
  final String rate;  
  final String change;  

  const CurrencyRateItem({required this.currency, required this.rate, required this.change});  

  @override  
  Widget build(BuildContext context) {  
    return ListTile(  
      title: Text(currency),  
      trailing: Column(  
        mainAxisAlignment: MainAxisAlignment.center,  
        children: [  
          Text(rate),  
          Text(change, style: TextStyle(color: Colors.green)),  
        ],  
      ),  
    );  
  }  
}
