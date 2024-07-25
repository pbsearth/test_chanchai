part of 'foodlist_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object?> get props => [];
}

class FetchFoodDataEvent extends FoodEvent {
  final String selectedSetId;
  final String searchQuery;

  const FetchFoodDataEvent({
    required this.selectedSetId,
    required this.searchQuery,
  });

  @override
  List<Object?> get props => [selectedSetId, searchQuery];
}

class AddFoodToOrderEvent extends FoodEvent {
  final Food food;

  const AddFoodToOrderEvent(this.food);

  @override
  List<Object> get props => [food];
}

class RemoveFoodFromOrderEvent extends FoodEvent {
  final Food food;

  const RemoveFoodFromOrderEvent(this.food);

  @override
  List<Object> get props => [food];
}

class UpdateFoodQuantityEvent extends FoodEvent {
  final Food food;
  final int quantity;

  const UpdateFoodQuantityEvent(this.food, this.quantity);

  @override
  List<Object> get props => [food, quantity];
}

class CalculateSubtotalEvent extends FoodEvent {}
