import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class FoodGrid extends StatelessWidget {
  final Map<String, List<Food>> groupedFood2;
  final void Function(Food food) onFoodTap;
  final double fontz;
  final double plusscreen;
  final ItemScrollController _scrollController;
  final ItemPositionsListener _itemPositionsListener;

  const FoodGrid({
    super.key,
    required this.groupedFood2,
    required this.onFoodTap,
    required this.fontz,
    required this.plusscreen,
    required ItemScrollController scrollController,
    required ItemPositionsListener itemPositionsListener,
  })  : _scrollController = scrollController,
        _itemPositionsListener = itemPositionsListener;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return ScrollablePositionedList.builder(
              itemScrollController: _scrollController,
              itemPositionsListener: _itemPositionsListener,
              itemCount: groupedFood2.length,
              itemBuilder: (context, index) {
                final foodCatName = groupedFood2.keys.elementAt(index);
                final foodItems = groupedFood2[foodCatName]!;
                bool isLastItem = index == groupedFood2.length - 1;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          plusscreen * 0.2, plusscreen * 0.1, 0, 0),
                      child: Text(
                        foodCatName,
                        style: GoogleFonts.roboto(
                          fontSize: plusscreen * 0.13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(plusscreen * 0.1,
                          plusscreen * 0.04, 0, plusscreen * 0.17),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              orientation == Orientation.landscape ? 4 : 2,
                          childAspectRatio:
                              (orientation == Orientation.landscape
                                      ? 22.w
                                      : 45.w) /
                                  (orientation == Orientation.landscape
                                      ? 41.h
                                      : 21.h),
                          mainAxisSpacing: 1.h,
                          crossAxisSpacing: 1.w,
                        ),
                        itemCount: foodItems.length,
                        itemBuilder: (context, index) {
                          final food = foodItems[index];

                          return Container(
                            margin: EdgeInsets.fromLTRB(
                                0, 0, plusscreen * 0.02, plusscreen * 0.05),
                            child: GestureDetector(
                              onTap: () => onFoodTap(food),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height:
                                          orientation == Orientation.landscape
                                              ? 41.h
                                              : 21.h,
                                      width:
                                          orientation == Orientation.landscape
                                              ? 22.w
                                              : 45.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      height:
                                          (orientation == Orientation.landscape
                                                  ? 35.h
                                                  : 24.h) -
                                              11.h,
                                      width:
                                          orientation == Orientation.landscape
                                              ? 22.w
                                              : 45.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(5)),
                                        image: food.imageName != null &&
                                                food.imageName!.isNotEmpty
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    food.imageName!),
                                                fit: BoxFit.cover,
                                              )
                                            : const DecorationImage(
                                                image: AssetImage(
                                                    'assets/image/noimage2.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  if (food.isOutStock == true)
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Opacity(
                                        opacity: 0.7,
                                        child: Container(
                                          height: (orientation ==
                                                      Orientation.landscape
                                                  ? 35.h
                                                  : 24.h) -
                                              11.h,
                                          width: orientation ==
                                                  Orientation.landscape
                                              ? 22.w
                                              : 45.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(5)),
                                            color: Colors.grey[300],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Out of Stock',
                                              style: GoogleFonts.roboto(
                                                fontSize: fontz * 1.3,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: plusscreen * 0.03,
                                          horizontal: plusscreen * 0.06),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 1,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      height:
                                          orientation == Orientation.landscape
                                              ? 18.h
                                              : 9.h,
                                      width:
                                          orientation == Orientation.landscape
                                              ? 22.w
                                              : 45.w,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            child: Text(
                                              food.foodName ?? 'No Name',
                                              style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: fontz * 0.6,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: plusscreen * 0.09,
                                            child: Text(
                                              food.foodDesc!,
                                              style: GoogleFonts.roboto(
                                                color: Colors.grey,
                                                fontSize: fontz * 0.5,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Text(
                                              food.isOutStock == false
                                                  ? '\$${food.foodPrice.toString()}'
                                                  : 'Sold Out',
                                              style: GoogleFonts.roboto(
                                                color: food.isOutStock == false
                                                    ? Colors.black
                                                    : Colors.red,
                                                decoration: food.isOutStock ==
                                                        false
                                                    ? TextDecoration.none
                                                    : TextDecoration.underline,
                                                decorationThickness:
                                                    food.isOutStock == false
                                                        ? 0
                                                        : 2,
                                                decorationColor:
                                                    food.isOutStock == false
                                                        ? Colors.transparent
                                                        : Colors.red,
                                                fontSize: fontz * 0.6,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (isLastItem)
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
