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

  const FoodSuccess({
    required this.foodList,
    required this.foodCategoryList,
    required this.foodSetList,
  });

  @override
  List<Object> get props => [foodList, foodCategoryList, foodSetList];
}

class FoodError extends FoodState {
  final String message;

  const FoodError({required this.message});

  @override
  List<Object> get props => [message];
}
