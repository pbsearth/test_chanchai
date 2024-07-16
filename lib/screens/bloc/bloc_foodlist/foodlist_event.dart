part of 'foodlist_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object?> get props => [];
}

class FetchFoodDataEvent extends FoodEvent {}
