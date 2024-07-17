import 'package:flutter/material.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllMenu extends StatefulWidget {
  final List<Food> foodList;
  final Function(Food) onFoodSelected;

  const AllMenu({
    Key? key,
    required this.foodList,
    required this.onFoodSelected,
  }) : super(key: key);

  @override
  State<AllMenu> createState() => _AllMenuState();
}

class _AllMenuState extends State<AllMenu> {
  List<String> selectedFoodIds = [];
  List<Food> selectedFoodItems = [];
  int selectedIndex3 = -1;

  void onFoodTap(Food food) {
    setState(() {
      final foodId = food.foodId.toString();

      selectedFoodIds.add(foodId);
      selectedFoodItems.add(food);
      print('add');

      widget.onFoodSelected(food);

      selectedIndex3 = selectedFoodIds.contains(foodId)
          ? -1
          : selectedFoodIds.indexOf(foodId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodList = widget.foodList;

    return OrientationBuilder(
      builder: (context, orientation) {
        return ResponsiveSizer(builder: (context, orientation, screenType) {
          int crossAxisCount;
          double containerHeight;
          double containerWidth;

          if (orientation == Orientation.landscape) {
            // Horizontal orientation
            crossAxisCount = 4;
            containerHeight = 35.h;
            containerWidth = 22.w;
          } else {
            // Vertical orientation
            crossAxisCount = 2;
            containerHeight = 30.h;
            containerWidth = 45.w;
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: containerWidth / containerHeight,
              mainAxisSpacing: 2.h,
              crossAxisSpacing: 2.w,
            ),
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              final food = foodList[index];

              return GestureDetector(
                onTap: () => onFoodTap(food),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Container(
                          height: containerHeight,
                          width: containerWidth,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(1, 5), // Shadow position
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Container(
                          height: containerHeight,
                          width: containerWidth,
                          decoration: const BoxDecoration(color: Colors.white),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Container(
                          height: containerHeight - 12.h,
                          width: containerWidth,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            image: food.imageName != null &&
                                    food.imageName!.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(food.imageName!),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image:
                                        AssetImage('assets/image/noimage2.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                          ),
                          height: 13.h,
                          width: containerWidth,
                          child: Padding(
                            padding: EdgeInsets.all(1.3.h),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food.foodName ?? 'No Name',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 1.5.h,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    food.foodDesc!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 1.1.h,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    ('\$${food.foodPrice.toString()}'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 1.2.h,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
      },
    );
  }
}
