import 'package:nutriscan/domain/entities/food_item.dart';
import 'package:nutriscan/domain/repositories/food_repository.dart';

class GetFoodItems {
  final FoodRepository repository;

  GetFoodItems(this.repository);

  Future<List<FoodItem>> call() {
    return repository.getFoodItems();
  }
}
