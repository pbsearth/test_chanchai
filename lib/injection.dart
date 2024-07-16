import 'package:get_it/get_it.dart';
import 'package:test_flutter/screens/bloc/bloc_foodlist/foodlist_bloc.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/repositories/reositories_food.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  //Repositories
  getIt.registerLazySingleton<FoodRepository>(() => FoodRepository());

  //BLoC
  getIt.registerFactory<FoodBloc>(() => FoodBloc(getIt<FoodRepository>()));
}
