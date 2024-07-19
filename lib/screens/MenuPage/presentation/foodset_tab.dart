import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class FoodSetList extends StatelessWidget {
  final List<FoodSet> foodSets;
  final String selectedSetId;
  final Function(String) onSetSelected;

  FoodSetList({
    Key? key,
    required this.foodSets,
    required this.selectedSetId,
    required this.onSetSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    // double plusscreen = (screenHeight + screenWidth) * 0.1;

    return Container(
      height: 11.h,
      padding: EdgeInsets.only(top: 1.h, left: 1.w, right: 1.w, bottom: 0.1.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foodSets.length,
        itemBuilder: (context, index) {
          final foodSet = foodSets[index];
          final isSelected = foodSet.foodSetId.toString() == selectedSetId;

          return GestureDetector(
            onTap: () => onSetSelected(foodSet.foodSetId.toString()),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 0.2.w),
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.5.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF02CCFE)
                    : const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: isSelected ? Colors.black : Colors.transparent,
                    width: 0.5),
              ),
              child: Center(
                child: Text(
                  foodSet.foodSetName!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Color(0xFFACACAC),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
