import 'package:bookshop/conrtrollers/CurrencyRateItemController.dart';
import 'package:bookshop/views/ExchangeCurrency.dart';
import 'package:flutter/material.dart';

class CurrencyRatesList extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return ListView(  
      children: [  
        CurrencyRateItem(currency: 'EUR', rate: '0.91', change: '0.3%'),  
        CurrencyRateItem(currency: 'GBP', rate: '0.78', change: '0.2%'),  
        CurrencyRateItem(currency: 'CHF', rate: '0.95', change: '0.1%'),  
        CurrencyRateItem(currency: 'BTC', rate: '0.00013', change: '1.0%'),  
      ],  
    );  
  }  
}  
