import 'package:bookshop/services/AuthService.dart';
import 'package:bookshop/services/ExchangeRateService.dart';
import 'package:bookshop/sharedPreferences/CurrencyPreferences.dart';
import 'package:bookshop/views/LoginScreen.dart';
import 'package:bookshop/widgets/CustomButtom.dart';
import 'package:bookshop/widgets/CustomDropdown.dart';
import 'package:bookshop/widgets/CustomHeader.dart';
import 'package:flutter/material.dart';

class ExchangeRatesScreen extends StatefulWidget {
  @override
  _ExchangeRatesScreenState createState() => _ExchangeRatesScreenState();
}

class _ExchangeRatesScreenState extends State<ExchangeRatesScreen> {
  final ExchangeRateService _exchangeRateService = ExchangeRateService();
  Map<String, dynamic>? exchangeRates;
  String _baseCurrency = 'USD';
  String? _targetCurrency = "USD";
  String? _convertCurrency = "PKR";
  bool isLoading = true;
  String _baseAmount = '1';
  String? _convertedAmount = '';
  List<String> currencies = [];
  final AuthService _authService = AuthService();
  final TextEditingController _baseController =
      TextEditingController(text: '1');
  final TextEditingController _convertController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
    _loadSavedCurrencies();
  }

  Future<void> fetchExchangeRates() async {
    setState(() {
      isLoading = true;
    });
    exchangeRates = await _exchangeRateService.getExchangeRates(
        baseCurrency: _baseCurrency);
    currencies = exchangeRates!['rates'].keys.toList();

    setState(() {
      isLoading = false;
    });

    convertCurrency();
  }

  Future<void> _loadSavedCurrencies() async {
    Map<String, String?> savedCurrencies =
        await CurrencyPreferences.loadSelectedCurrencies();
    setState(() {
      _targetCurrency = savedCurrencies['targetCurrency'] ?? "USD";
      _convertCurrency = savedCurrencies['convertCurrency'] ?? "PKR";
      _baseCurrency = savedCurrencies['targetCurrency'] ?? "USD";
    });
    fetchExchangeRates();
  }

  void convertCurrency() {
    print(_baseAmount);
    if (_baseAmount.isNotEmpty && exchangeRates != null) {
      final double baseAmount = double.parse(_baseAmount);
      final double exchangeRate =
          exchangeRates!['rates'][_targetCurrency] ?? 1.0;
      final double convertedAmount = baseAmount * exchangeRate;
      final double newAmount =
          convertedAmount * (exchangeRates!['rates'][_convertCurrency] ?? 1.0);
      final String formattedAmount = newAmount.toStringAsFixed(2);
      print('$formattedAmount formattedAmount');
      _convertController.text = formattedAmount;
      setState(() {
        _convertedAmount = formattedAmount;
      });
    }
  }

  List<DropdownMenuItem<String>> get _currencyItems {
    return currencies.map((currency) {
      return DropdownMenuItem<String>(
        value: currency,
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(
                'https://flagcdn.com/32x24/${currency.toLowerCase().substring(0, 2)}.png',
              ),
            ),
            const SizedBox(width: 8),
            Text(currency),
          ],
        ),
      );
    }).toList();
  }

  void swapCurrencies() {
    setState(() {
      String temp = _targetCurrency!;
      _targetCurrency = _convertCurrency;
      _convertCurrency = temp;
      _baseCurrency = _convertCurrency!;
    });
    fetchExchangeRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: 'Login',
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
                    child: Text('Cancel', style: TextStyle(color: Colors.pink)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Logout', style: TextStyle(color: Colors.pink)),
                  ),
                ],
              ),
            );

            if (confirmLogout) {
              await _authService.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            }
          },
          icon: const Icon(Icons.logout, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // !isLoading
          //     ? const Center(child: CircularProgressIndicator())
          //     :
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomDropdown<String>(
                  value: _targetCurrency,
                  items: _currencyItems,
                  hintText: "Enter value",
                  textChange: (newValue) {
                    _baseAmount = newValue;
                    convertCurrency();
                  },
                  onChanged: (String? newValue) async {
                    setState(() {
                      _baseCurrency = newValue!;
                      _targetCurrency = newValue;
                    });
                    await CurrencyPreferences.saveSelectedCurrencies(
                        newValue!, _convertCurrency!);
                    fetchExchangeRates();
                  },
                  textController: _baseController,
                  hint: 'Select a currency',
                ),
              ),
              IconButton(
                onPressed: swapCurrencies,
                icon: const Icon(Icons.change_circle_outlined),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomDropdown<String>(
                  value: _convertCurrency,
                  items: _currencyItems,
                  readOnly: true,
                  textChange: (newValue) {},
                  onChanged: (String? newValue) async {
                    setState(() {
                      _convertCurrency = newValue;
                    });
                    await CurrencyPreferences.saveSelectedCurrencies(
                        _targetCurrency!, newValue!);
                    fetchExchangeRates();
                  },
                  textController: _convertController,
                  hint: 'Select a currency',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: "Create Alert",
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AlertScreen()),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
