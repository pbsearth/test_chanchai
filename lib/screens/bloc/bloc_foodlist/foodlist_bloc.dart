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
        final foodEntity = await foodRepository.fetchFoodData();
        emit(FoodSuccess(
          foodList: foodEntity.result?.food ?? [],
          foodCategoryList: foodEntity.result?.foodCategory ?? [],
          foodSetList: foodEntity.result?.foodSet ?? [],
        ));
      } catch (e) {
        emit(FoodError(message: e.toString()));
      }
    });
  }
}
