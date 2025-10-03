import 'package:hive_flutter/hive_flutter.dart';
import 'package:nutriscan/data/local/models/food_item_model.dart';

class HiveService {
  static const String _boxName = 'foodItems';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FoodItemModelAdapter());
    await Hive.openBox<FoodItemModel>(_boxName);
  }

  Box<FoodItemModel> getFoodItemBox() {
    return Hive.box<FoodItemModel>(_boxName);
  }

  Future<void> addFoodItem(FoodItemModel foodItem) async {
    final box = getFoodItemBox();
    await box.add(foodItem);
  }

  List<FoodItemModel> getFoodItems() {
    final box = getFoodItemBox();
    return box.values.toList();
  }
}
