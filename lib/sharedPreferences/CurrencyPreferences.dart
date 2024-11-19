import 'package:shared_preferences/shared_preferences.dart';

class CurrencyPreferences {
  static const String _targetCurrencyKey = 'targetCurrency';
  static const String _convertCurrencyKey = 'convertCurrency';

  static Future<void> saveSelectedCurrencies(String targetCurrency, String convertCurrency) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_targetCurrencyKey, targetCurrency);
    await prefs.setString(_convertCurrencyKey, convertCurrency);
  }

  static Future<Map<String, String?>> loadSelectedCurrencies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? targetCurrency = prefs.getString(_targetCurrencyKey);
    String? convertCurrency = prefs.getString(_convertCurrencyKey);
    return {
      'targetCurrency': targetCurrency,
      'convertCurrency': convertCurrency,
    };
  }
}
