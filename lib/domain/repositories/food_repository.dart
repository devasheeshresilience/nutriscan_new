import 'package:nutriscan/domain/entities/food_item.dart';

abstract class FoodRepository {
  Future<void> addFoodItem(FoodItem foodItem);
  Future<List<FoodItem>> getFoodItems();
}
