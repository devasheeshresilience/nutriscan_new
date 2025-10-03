import 'package:hive/hive.dart';

part 'food_item_model.g.dart';

@HiveType(typeId: 0)
class FoodItemModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double calories;

  @HiveField(2)
  final double fats;

  @HiveField(3)
  final double proteins;

  @HiveField(4)
  final double carbs;

  @HiveField(5)
  final double sugar;

  @HiveField(6)
  final double fiber;

  @HiveField(7)
  final double sodium;

  @HiveField(8)
  final DateTime date;

  FoodItemModel({
    required this.name,
    required this.calories,
    required this.fats,
    required this.proteins,
    required this.carbs,
    required this.sugar,
    required this.fiber,
    required this.sodium,
    required this.date,
  });
}
