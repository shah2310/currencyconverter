import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CurrencyGraph extends StatelessWidget {
  final List<double> exchangeRates;
  final List<String> dates;

  CurrencyGraph({required this.exchangeRates, required this.dates});

  @override
  Widget build(BuildContext context) {
  if (exchangeRates.isEmpty || dates.isEmpty || exchangeRates.length != dates.length) {
      return Center(
        child: Text(
          "No data available for the graph",
          style: TextStyle(color: Colors.red),
        ),
      );
    }
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: exchangeRates
                .asMap()
                .entries
                .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                .toList(),
            isCurved: true,
            // colors: [Colors.blue],
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value % 2 == 0) {
                  return Text(
                    dates[value.toInt()],
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const SizedBox.shrink();
              },
              reservedSize: 22,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(2),
                  style: const TextStyle(fontSize: 10),
                );
              },
              reservedSize: 32,
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        gridData: FlGridData(show: true),
      ),
    );
  }
}
