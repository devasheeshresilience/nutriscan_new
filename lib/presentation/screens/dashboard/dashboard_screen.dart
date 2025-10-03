import 'package:flutter/material.dart';
import 'package:nutriscan/domain/usecases/get_daily_intake.dart';
import 'package:nutriscan/presentation/widgets/nutrition_chart.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: FutureBuilder<Map<String, double>>(
        future: Provider.of<GetDailyIntake>(context, listen: false)(DateTime.now()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading dashboard'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data for today.'));
          }

          final data = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Today\'s Intake: ${data['calories']?.toStringAsFixed(0) ?? 0} kcal',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: NutritionChart(data: {
                    'fats': data['fats'] ?? 0,
                    'proteins': data['proteins'] ?? 0,
                    'carbs': data['carbs'] ?? 0,
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
