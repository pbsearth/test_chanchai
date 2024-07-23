import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/screens/MenuPage/presentation/food_style.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class FoodGrid extends StatelessWidget {
  final ItemScrollController scrollController;
  final ItemPositionsListener itemPositionsListener;
  final Map<String, List<Food>> groupedFood;
  final Function(Food) onFoodTap;

  FoodGrid({
    Key? key,
    required this.scrollController,
    required this.itemPositionsListener,
    required this.groupedFood,
    required this.onFoodTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return ResponsiveSizer(builder: (context, orientation, screenType) {
        return ScrollablePositionedList.builder(
          itemScrollController: scrollController,
          itemPositionsListener: itemPositionsListener,
          itemCount: groupedFood.length,
          itemBuilder: (context, index) {
            final categoryName = groupedFood.keys.elementAt(index);
            final foodsInCategory = groupedFood[categoryName] ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                  child: Text(
                    categoryName,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 5.h),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          orientation == Orientation.landscape ? 4 : 2,
                      childAspectRatio: 1.0,
                      // childAspectRatio: (orientation == Orientation.landscape
                      //         ? 22.w
                      //         : 45.w) /
                      //     (orientation == Orientation.landscape ? 20.h : 20.h),
                      // mainAxisSpacing: 0.h,
                      // crossAxisSpacing: 0.w,
                    ),
                    itemCount: foodsInCategory.length,
                    itemBuilder: (context, foodIndex) {
                      final food = foodsInCategory[foodIndex];
                      return FoodItem(
                        food: food,
                        onFoodTap: onFoodTap,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      });
    });
  }
}
