import 'package:flutter/material.dart';
import 'package:test_flutter/screens/MenuPage/presentation/soldout_style.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FoodItem extends StatelessWidget {
  final Food food;
  final Function(Food) onFoodTap;

  FoodItem({
    Key? key,
    required this.food,
    required this.onFoodTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onFoodTap(food),
      child: Stack(
        children: [
          Container(
            height: 65.h,
            margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.5),
            // padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
              color: Colors.amber,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    food.imageName ?? '',
                    // height: 60.sp,
                    // width: 60.sp,
                    fit: BoxFit.cover,
                  ),
                ),
                // SizedBox(height: 8.0),
                Stack(
                  children: [
                    Text(
                      food.foodName ?? '',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (food.isOutStock == true) OutOfStockOverlay(),
        ],
      ),
    );
  }
}
