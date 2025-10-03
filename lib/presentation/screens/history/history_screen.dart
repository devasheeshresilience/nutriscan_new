import 'package:flutter/material.dart';
import 'package:nutriscan/domain/entities/food_item.dart';
import 'package:nutriscan/domain/usecases/get_food_items.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: FutureBuilder<List<FoodItem>>(
        future: Provider.of<GetFoodItems>(context, listen: false)(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading history'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items in history.'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text(
                    '${item.calories.toStringAsFixed(0)} kcal - ${item.date.toLocal()}'),
                trailing: Text(
                    'P: ${item.proteins}g, C: ${item.carbs}g, F: ${item.fats}g'),
              );
            },
          );
        },
      ),
    );
  }
}
