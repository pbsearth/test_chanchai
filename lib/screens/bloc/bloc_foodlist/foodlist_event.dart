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

// abstract class FoodEvent extends Equatable {
//   const FoodEvent();

//   @override
//   List<Object?> get props => [];
// }

// class FetchFoodDataEvent extends FoodEvent {}
