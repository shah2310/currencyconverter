import 'package:bookshop/views/ExchangeCurrency.dart';
import 'package:bookshop/views/TransactionItem.dart';
import 'package:flutter/material.dart';

class Walletscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hello, Mustufa")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('USD', style: TextStyle(fontSize: 18)),
                    Text('\$3,500',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                CircularProgressIndicator(value: 0.70),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  TransactionItem(description: 'Starbucks', amount: '- \$4'),
                  TransactionItem(description: 'Taxi', amount: '- \$15'),
                  TransactionItem(description: 'TK Maxx', amount: '- \$135'),
                  TransactionItem(description: 'Income', amount: '+ \$2,350'),
                  TransactionItem(
                      description: 'Outfit Boutiq', amount: '- \$50'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exchangecurrency()),
                );
              },
              child: Text('Exchange Currency'),
            ),
          ],
        ),
      ),
    );
  }
}
