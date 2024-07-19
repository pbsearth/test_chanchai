import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/screens/MenuPage/presentation/all_menulist.dart';
import 'package:test_flutter/screens/MenuPage/presentation/order.dart';
import 'package:test_flutter/screens/MenuPage/widgets/foodlist.dart';
import 'package:test_flutter/screens/bloc/bloc_foodlist/foodlist_bloc.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class MenuPage2 extends StatelessWidget {
  MenuPage2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Food> selectedFoodItems = [];

    return Scaffold(
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodInitial) {
            return const Center(
              child: Text('Press button to fetch food data'),
            );
          } else if (state is FoodLoading) {
            return const SizedBox(
              width: double.infinity,
              height: 0.5,
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF02ccfe),
                ),
              ),
            );
          } else if (state is FoodSuccess) {
            return Row(
              children: [
                Expanded(
                  flex: 4,
                  child: AllMenu2(
                    foodList: state.foodList,
                    foodSets: state.foodSetList,
                    onFoodSelected: (food) {
                      // Handle food selection
                    },
                    foodcat: state.foodCategoryList,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: OrderSummary(
                    selectedFoodItems: selectedFoodItems,
                  ),
                ),
              ],
            );
          } else if (state is FoodError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }
          return Container();
        },
      ),
    );
  }
}
