import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class OrderSummary extends StatelessWidget {
  final List<Food> selectedFoodItems;

  OrderSummary({
    Key? key,
    required this.selectedFoodItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100.h, // Adjust height as needed
        width: 100.w, // Adjust width as needed
        color: Colors.black,
        child: Column(
          children: [
            Container(
              height: 20.h,
              width: 100.w,
              color: Colors.greenAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    height: 7.h,
                    color: Colors.amberAccent,
                    child: buildTopRow(),
                  ),
                  Container(
                    width: 100.w,
                    height: 12.h,
                    color: Colors.redAccent,
                    child: ListView.builder(
                      itemCount: selectedFoodItems.length,
                      itemBuilder: (context, index) {
                        final selectedFood = selectedFoodItems[index];
                        return ListTile(
                          title: Text(selectedFood.foodName ?? ''),
                          subtitle: Text('ID: ${selectedFood.foodId}'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTopRow() {
    return Row(
      children: [
        Text(
          'Order Summary',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          'Total Items: ${selectedFoodItems.length}',
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }
}
