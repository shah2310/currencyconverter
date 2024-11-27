import 'dart:async';
import 'dart:developer';

import 'package:bookshop/functions/showNotification.dart';
import 'package:flutter/material.dart';

class RateChecker extends StatefulWidget {
  final double targetRate;
  final String baseCurrency;
  final String convertCurrency;

  const RateChecker({
    required this.targetRate,
    required this.baseCurrency,
    required this.convertCurrency,
    Key? key,
  }) : super(key: key);

  @override
  _RateCheckerState createState() => _RateCheckerState();
}

class _RateCheckerState extends State<RateChecker> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      log("message");
      checkExchangeRate(widget.targetRate, widget.baseCurrency, widget.convertCurrency);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rate Checker')),
      body: const Center(child: Text('Monitoring exchange rates...')),
    );
  }
}
