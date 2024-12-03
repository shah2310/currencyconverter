import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CurrencyGraph extends StatefulWidget {
  final List<double> exchangeRates;
  final List<String> dates;

  const CurrencyGraph({Key? key, required this.exchangeRates, required this.dates}) : super(key: key);

  @override
  _CurrencyGraphState createState() => _CurrencyGraphState();
}

class _CurrencyGraphState extends State<CurrencyGraph> {
  late List<FlSpot> validSpots;

@override
void initState() {
  super.initState();

  // Ensure valid data is processed in initState
  validSpots = widget.exchangeRates.asMap().entries
      .where((entry) => entry.value.isFinite) // Filter out invalid values
      .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
      .toList();

  // Print debug information
  print('Exchange Rates: ${widget.exchangeRates}');
  print('Dates: ${widget.dates}');
  print('Valid Spots: $validSpots');
}


  @override
  Widget build(BuildContext context) {
    if (widget.exchangeRates.isEmpty ||
        widget.dates.isEmpty ||
        widget.exchangeRates.length != widget.dates.length) {
      return Center(
        child: Text(
          "No data available for the graph",
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
  if (validSpots.isEmpty) {
    return Center(
      child: Text(
        "Invalid data points",
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
return LineChart(
  LineChartData(
    lineBarsData: [
      LineChartBarData(
        spots: validSpots,
        isCurved: true,
        barWidth: 4,
      ),
    ],
  ),
);
  }
}