import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class SearchResultsGrid extends StatelessWidget {
  final List<Food> filteredFoodList;
  final Function(Food) onFoodSelected;

  const SearchResultsGrid({
    super.key,
    required this.filteredFoodList,
    required this.onFoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen = (screenHeight + screenWidth) * 0.1;
    double fontz = plusscreen * 0.1;

    if (filteredFoodList.isEmpty) {
      return const Center(child: Text('No results found'));
    }

    return OrientationBuilder(builder: (context, orientation) {
      return ResponsiveSizer(builder: (context, orientation, screenType) {
        return GridView.builder(
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.landscape ? 4 : 2,
            childAspectRatio: (orientation == Orientation.landscape
                    ? plusscreen * 0.5
                    : plusscreen * 0.5) /
                (orientation == Orientation.landscape
                    ? plusscreen * 0.5
                    : plusscreen * 0.5),
          ),
          itemCount: filteredFoodList.length,
          itemBuilder: (context, index) {
            final foodItem = filteredFoodList[index];
            return Container(
              margin: EdgeInsets.symmetric(
                  horizontal: plusscreen * 0.03, vertical: plusscreen * 0.03),
              child: GestureDetector(
                onTap: () => onFoodSelected(foodItem),
                child: Stack(children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      height: orientation == Orientation.landscape
                          ? plusscreen * 0.7
                          : plusscreen * 1,
                      width: plusscreen * 0.5,
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
                      height: orientation == Orientation.landscape
                          ? plusscreen * 0.7
                          : plusscreen * 0.7,
                      width: plusscreen * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(5),
                        ),
                        image: foodItem.imageName != null &&
                                foodItem.imageName!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(foodItem.imageName!),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage('assets/image/noimage2.jpg'),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  if (foodItem.isOutStock == true)
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Opacity(
                        opacity: 0.7,
                        child: Container(
                          height: orientation == Orientation.landscape
                              ? plusscreen * 0.7
                              : plusscreen * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(5),
                            ),
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
                        padding: EdgeInsets.all(plusscreen * 0.05),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        height: plusscreen * 0.5,
                        width: plusscreen * 0.5,
                        child: Stack(children: [
                          Positioned(
                            top: 0,
                            child: Text(
                              foodItem.foodName ?? 'No Name',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: fontz * 0.7,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Positioned(
                            top: plusscreen * 0.1,
                            child: Text(
                              foodItem.foodDesc!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fontz * 0.6,
                              ),
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          if (foodItem.isOutStock == false)
                            Positioned(
                              bottom: 0,
                              child: Text(
                                '\$${foodItem.foodPrice.toString()}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: fontz * 0.7,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          if (foodItem.isOutStock == true)
                            Positioned(
                              bottom: 0,
                              child: Text(
                                'Sold Out',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: fontz * 0.7,
                                  fontWeight: FontWeight.bold,
                                  decoration:
                                      orientation == Orientation.landscape
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                  decorationThickness: 2,
                                  decorationColor: Colors.red,
                                ),
                              ),
                            ),
                        ]),
                      ))
                ]),
              ),
            );
          },
        );
      });
    });
  }
}
