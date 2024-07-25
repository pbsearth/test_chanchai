part of 'foodlist_bloc.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodSuccess extends FoodState {
  final List<Food> foodList;
  final List<FoodCategory> foodCategoryList;
  final List<FoodSet> foodSetList;
  final Map<String, List<Food>> groupedFood;
  final Map<Food, int> order;
  final double subtotal;

  const FoodSuccess({
    required this.foodList,
    required this.foodCategoryList,
    required this.foodSetList,
    required this.groupedFood,
    required this.order,
    required this.subtotal,
  });

  FoodSuccess copyWith({
    List<Food>? foodList,
    List<FoodCategory>? foodCategoryList,
    List<FoodSet>? foodSetList,
    Map<String, List<Food>>? groupedFood,
    Map<Food, int>? order,
    double? subtotal,
  }) {
    return FoodSuccess(
      foodList: foodList ?? this.foodList,
      foodCategoryList: foodCategoryList ?? this.foodCategoryList,
      foodSetList: foodSetList ?? this.foodSetList,
      groupedFood: groupedFood ?? this.groupedFood,
      order: order ?? this.order,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  @override
  List<Object> get props => [
        foodList,
        foodCategoryList,
        foodSetList,
        groupedFood,
        order,
        subtotal,
      ];
}

class FoodError extends FoodState {
  final String message;

  const FoodError({required this.message});

  @override
  List<Object> get props => [message];
}
