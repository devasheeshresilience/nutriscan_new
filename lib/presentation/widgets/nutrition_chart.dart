import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class NutritionChart extends StatelessWidget {
  final Map<String, double> data;

  const NutritionChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: _generateSections(),
        centerSpaceRadius: 40,
        sectionsSpace: 2,
      ),
    );
  }

  List<PieChartSectionData> _generateSections() {
    return data.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: '${entry.key}\n${entry.value.toStringAsFixed(1)}g',
        color: _getColor(entry.key),
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Color _getColor(String key) {
    switch (key) {
      case 'fats':
        return Colors.orange;
      case 'proteins':
        return Colors.blue;
      case 'carbs':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
