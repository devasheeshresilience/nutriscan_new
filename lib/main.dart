import 'package:flutter/material.dart';
import 'package:nutriscan/config/app_theme.dart';
import 'package:nutriscan/data/local/hive_service.dart';
import 'package:nutriscan/navigation/app_router.dart';
import 'package:provider/provider.dart';
import 'package:nutriscan/domain/usecases/add_food_item.dart';
import 'package:nutriscan/domain/usecases/get_daily_intake.dart';
import 'package:nutriscan/domain/usecases/get_food_items.dart';
import 'package:nutriscan/data/repository/food_repository_impl.dart';
import 'package:nutriscan/domain/repositories/food_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveService = HiveService();
  await hiveService.init();
  runApp(MyApp(hiveService: hiveService));
}

class MyApp extends StatelessWidget {
  final HiveService hiveService;

  const MyApp({super.key, required this.hiveService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HiveService>.value(value: hiveService),
        Provider<FoodRepository>(
          create: (_) => FoodRepositoryImpl(hiveService),
        ),
        ProxyProvider<FoodRepository, AddFoodItem>(
          update: (context, repository, previous) => AddFoodItem(repository),
        ),
        ProxyProvider<FoodRepository, GetFoodItems>(
          update: (context, repository, previous) => GetFoodItems(repository),
        ),
        ProxyProvider<FoodRepository, GetDailyIntake>(
          update: (context, repository, previous) => GetDailyIntake(repository),
        ),
      ],
      child: MaterialApp.router(
        title: 'NutriScan',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}

