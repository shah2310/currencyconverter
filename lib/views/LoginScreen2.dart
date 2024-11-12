import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

void main() {
  runApp(const Loginscreen2());
}

class Loginscreen2 extends StatelessWidget {
  const Loginscreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  late Map<String, dynamic> _rates;
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _amount = 1.0;
  double _result = 0.0;

  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.text = _amount.toString();
    _fetchExchangeRates();
  }

  Future<void> _fetchExchangeRates() async {
    final url = 'https://api.exchangerate-api.com/v4/latest/$_fromCurrency';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        _rates = json.decode(response.body)['rates'];
        _convertCurrency();
      });
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  void _convertCurrency() {
    setState(() {
      if (_rates.isNotEmpty) {
        _result = _amount * _rates[_toCurrency];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Amount Input
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _amount = double.tryParse(value) ?? 1.0;
                  _convertCurrency();
                });
              },
            ),
            const SizedBox(height: 20),

            // From Currency Dropdown
            DropdownButton<String>(
              value: _fromCurrency,
              onChanged: (newValue) {
                setState(() {
                  _fromCurrency = newValue!;
                  _fetchExchangeRates();
                });
              },
              items: [
                'USD',
                'EUR',
                'GBP',
                'INR',
                'AUD',
                'SAR',
              ]
                  .map((currency) => DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),

            // To Currency Dropdown
            DropdownButton<String>(
              value: _toCurrency,
              onChanged: (newValue) {
                setState(() {
                  _toCurrency = newValue!;
                  _convertCurrency();
                });
              },
              items: ['USD', 'EUR', 'GBP', 'INR', 'AUD', 'PKR']
                  .map((currency) => DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Result
            Text(
              'Result: ${_result.toStringAsFixed(2)} $_toCurrency',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
