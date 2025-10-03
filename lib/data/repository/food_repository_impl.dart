import 'package:nutriscan/domain/entities/food_item.dart';
import 'package:nutriscan/domain/repositories/food_repository.dart';
import 'package:nutriscan/data/local/hive_service.dart';
import 'package:nutriscan/data/local/models/food_item_model.dart';

class FoodRepositoryImpl implements FoodRepository {
  final HiveService _hiveService;

  FoodRepositoryImpl(this._hiveService);

  @override
  Future<void> addFoodItem(FoodItem foodItem) async {
    final foodItemModel = FoodItemModel(
      name: foodItem.name,
      calories: foodItem.calories,
      fats: foodItem.fats,
      proteins: foodItem.proteins,
      carbs: foodItem.carbs,
      sugar: foodItem.sugar,
      fiber: foodItem.fiber,
      sodium: foodItem.sodium,
      date: foodItem.date,
    );
    await _hiveService.addFoodItem(foodItemModel);
  }

  @override
  Future<List<FoodItem>> getFoodItems() async {
    final foodItemModels = _hiveService.getFoodItems();
    return foodItemModels
        .map((model) => FoodItem(
              name: model.name,
              calories: model.calories,
              fats: model.fats,
              proteins: model.proteins,
              carbs: model.carbs,
              sugar: model.sugar,
              fiber: model.fiber,
              sodium: model.sodium,
              date: model.date,
            ))
        .toList();
  }
}
