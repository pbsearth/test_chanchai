import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/repositories/reositories_food.dart';

part 'foodlist_event.dart';
part 'foodlist_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository;

  FoodBloc(this.foodRepository) : super(FoodInitial()) {
    on<FetchFoodDataEvent>((event, emit) async {
      emit(FoodLoading());
      try {
        print('new');

        final foodEntity = await foodRepository.fetchFoodData();
        final foodList = foodEntity.result?.food ?? [];
        final foodCategoryList = foodEntity.result?.foodCategory ?? [];
        final foodSetList = foodEntity.result?.foodSet ?? [];

        final filteredFoodList = _filterFoodList(
          foodList,
          event.selectedSetId,
          event.searchQuery,
        );
        final groupedFood = _groupFoodByCategory(
          filteredFoodList,
          foodCategoryList,
        );

        emit(FoodSuccess(
          foodList: filteredFoodList,
          foodCategoryList: foodCategoryList,
          foodSetList: foodSetList,
          groupedFood: groupedFood,
        ));
      } catch (e) {
        emit(FoodError(message: e.toString()));
      }
    });
  }

  List<Food> _filterFoodList(
      List<Food> foodList, String selectedSetId, String searchQuery) {
    return foodList.where((food) {
      final matchesSetId = food.foodSetId == selectedSetId;
      final matchesSearchQuery = searchQuery.isEmpty ||
          (food.foodName?.toLowerCase().contains(searchQuery.toLowerCase()) ??
              false);
      return matchesSetId && matchesSearchQuery;
    }).toList();
  }

  Map<String, List<Food>> _groupFoodByCategory(
      List<Food> foodList, List<FoodCategory> foodCategoryList) {
    final groupedFood = <String, List<Food>>{};
    final foodCatMap = <String, String>{};
    final foodCatSortingMap = <String, int>{};

    for (var foodCat in foodCategoryList) {
      if (foodCat.active!) {
        foodCatMap[foodCat.foodCatId!] = foodCat.foodCatName!;
        foodCatSortingMap[foodCat.foodCatId!] = foodCat.foodCatSorting ?? 0;
      }
    }

    for (var food in foodList) {
      if (foodCatMap.containsKey(food.foodCatId)) {
        final foodCatName = foodCatMap[food.foodCatId]!;
        groupedFood.putIfAbsent(foodCatName, () => []).add(food);
      }
    }

    final sortedCategoryNames = foodCatSortingMap.entries
        .where((entry) => groupedFood.containsKey(foodCatMap[entry.key]))
        .toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    final sortedGroupedFood = <String, List<Food>>{};
    for (var entry in sortedCategoryNames) {
      final categoryName = foodCatMap[entry.key]!;
      sortedGroupedFood[categoryName] = groupedFood[categoryName]!;
    }

    return sortedGroupedFood;
  }
}


// class FoodBloc extends Bloc<FoodEvent, FoodState> {
//   final FoodRepository foodRepository;

//   FoodBloc(this.foodRepository) : super(FoodInitial()) {
//     on<FetchFoodDataEvent>((event, emit) async {
//       emit(FoodLoading());
//       try {
//         final foodEntity = await foodRepository.fetchFoodData();
//         emit(FoodSuccess(
//           foodList: foodEntity.result?.food ?? [],
//           foodCategoryList: foodEntity.result?.foodCategory ?? [],
//           foodSetList: foodEntity.result?.foodSet ?? [],
//         ));
//       } catch (e) {
//         emit(FoodError(message: e.toString()));
//       }
//     });
//   }
// }
