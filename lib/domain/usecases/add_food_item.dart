import 'package:nutriscan/domain/entities/food_item.dart';
import 'package:nutriscan/domain/repositories/food_repository.dart';

class AddFoodItem {
  final FoodRepository repository;

  AddFoodItem(this.repository);

  Future<void> call(FoodItem foodItem) {
    return repository.addFoodItem(foodItem);
  }
}
