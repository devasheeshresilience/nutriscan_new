import 'package:nutriscan/domain/entities/food_item.dart';
import 'package:nutriscan/domain/repositories/food_repository.dart';

class GetDailyIntake {
  final FoodRepository repository;

  GetDailyIntake(this.repository);

  Future<Map<String, double>> call(DateTime date) async {
    final items = await repository.getFoodItems();
    final todayItems = items.where((item) =>
        item.date.year == date.year &&
        item.date.month == date.month &&
        item.date.day == date.day);

    double totalCalories = 0;
    double totalFats = 0;
    double totalProteins = 0;
    double totalCarbs = 0;

    for (var item in todayItems) {
      totalCalories += item.calories;
      totalFats += item.fats;
      totalProteins += item.proteins;
      totalCarbs += item.carbs;
    }

    return {
      'calories': totalCalories,
      'fats': totalFats,
      'proteins': totalProteins,
      'carbs': totalCarbs,
    };
  }
}
