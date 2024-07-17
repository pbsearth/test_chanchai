import 'package:flutter/material.dart';
import 'package:test_flutter/screens/bloc/bloc_foodlist/foodlist_bloc.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class FoodListView extends StatelessWidget {
  final List<Food> foodList;
  final List<String> selectedFoodIds;
  final List<Food> selectedFoodItems;
  final Function(FoodState, String) onFoodTap;
  final Function(List<String>, List<Food>) updateSelectedFood;
  final FoodState state;

  const FoodListView({
    Key? key,
    required this.foodList,
    required this.selectedFoodIds,
    required this.selectedFoodItems,
    required this.onFoodTap,
    required this.updateSelectedFood,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen = screenHeight + screenWidth;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > constraints.maxHeight) {
          return buildGridView(4, screenHeight, screenWidth, plusscreen);
        } else {
          return buildGridView(2, screenHeight, screenWidth, plusscreen);
        }
      },
    );
  }

  Widget buildGridView(
      int columns, double screenHeight, double screenWidth, double plusscreen) {
    return ListView.builder(
      itemCount: (foodList.length / columns).ceil(),
      itemBuilder: (context, rowIndex) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(columns, (colIndex) {
            final index = rowIndex * columns + colIndex;
            if (index < foodList.length) {
              final foodId = foodList[index].foodId;
              final isSelected = selectedFoodIds.contains(foodId);

              return GestureDetector(
                onTap: () {
                  onFoodTap(state, foodId!);
                  updateSelectedFood(
                    selectedFoodIds.contains(foodId)
                        ? (selectedFoodIds..remove(foodId)).toList()
                        : (selectedFoodIds..add(foodId.toString())).toList(),
                    selectedFoodIds.contains(foodId)
                        ? foodList
                            .where((item) => item.foodId != foodId)
                            .toList()
                        : (foodList..add(foodList[index])).toList(),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: plusscreen * 0.0005,
                    vertical: plusscreen * 0.002,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.15,
                        width: screenWidth * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF02ccfe)
                                : Colors.transparent,
                            width: 3,
                          ),
                          image: foodList[index].imageName != null &&
                                  foodList[index].imageName!.isNotEmpty
                              ? DecorationImage(
                                  image:
                                      NetworkImage(foodList[index].imageName!),
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  image:
                                      AssetImage('assets/image/noimage2.jpg'),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF02ccfe)
                              : Colors.amberAccent,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                        ),
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.15,
                        child: Center(
                          child: Text(
                            foodList[index].foodName ?? 'No Name',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox(width: plusscreen * 0.1);
            }
          }),
        );
      },
    );
  }
}
