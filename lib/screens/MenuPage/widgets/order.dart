// order_summary.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class OrderSummary extends StatelessWidget {
  final List<Food> selectedFoodItems;
  final Map<String, int> foodQuantities;
  final double subtotal;
  final int countorder;
  final void Function(Food foodItem, int quantity) onUpdateFoodQuantity;
  final void Function(Food foodItem) onRemoveFoodItem;

  const OrderSummary({
    super.key,
    required this.selectedFoodItems,
    required this.foodQuantities,
    required this.subtotal,
    required this.countorder,
    required this.onUpdateFoodQuantity,
    required this.onRemoveFoodItem,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen = (screenHeight + screenWidth) * 0.1;
    double fontz = plusscreen * 0.1;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          plusscreen * 0.1, plusscreen * 0.1, plusscreen * 0.1, 0),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: plusscreen * 0.4,
            child: Container(
              height: screenHeight * 0.8,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: buildSelectedFoodList(
                    screenHeight, screenWidth, plusscreen, fontz),
              ),
            ),
          ),
          if (countorder == 0)
            Positioned(
              right: 0,
              left: 0,
              top: plusscreen * 0.4,
              child: SizedBox(
                  height: screenHeight * 0.8,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: plusscreen * 0.1,
                      ),
                      Text(
                        'No order selected',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: fontz * 0.8),
                      ),
                    ],
                  )),
            ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: plusscreen * 0.12,
                      width: plusscreen * 0.12,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/image/flag_usa.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'My Order',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: fontz * 1.2),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'assets/svg/edit.svg',
                        height: fontz * 1,
                        width: fontz * 1,
                      ),
                      // Icon(
                      //   Icons.edit_square,
                      //   size: fontz * 1.2,
                      // )
                    ],
                  ),
                  const Divider(
                    thickness: 0.3,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  const Divider(
                    thickness: 0.3,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: plusscreen * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w500, fontSize: fontz * 1),
                        ),
                        Text(
                          '\$${subtotal.toStringAsFixed(2)}',
                          style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w500, fontSize: fontz * 1),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: plusscreen * 0.1),
                    width: double.infinity,
                    height: plusscreen * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: selectedFoodItems.isNotEmpty
                          ? const Color(0xFF32CD32)
                          : const Color(0xFF8D8D8D),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/shopping.svg',
                          height: fontz * 1.2,
                          width: fontz * 1.2,
                        ),
                        Text('Confirm Order',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: fontz * 0.8,
                                color: Colors.white)),
                        Text('($countorder)',
                            style: GoogleFonts.workSans(
                                fontWeight: FontWeight.w400,
                                fontSize: fontz * 0.8,
                                color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectedFoodList(double screenHeight, double screenWidth,
      double plusscreen, double fontz) {
    if (selectedFoodItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: selectedFoodItems.map(
        (foodItem) {
          final foodId = foodItem.foodId.toString();
          final quantity = foodQuantities[foodId] ?? 0;

          return Padding(
            padding: EdgeInsets.symmetric(vertical: plusscreen * 0.02),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: plusscreen * 0.05, vertical: plusscreen * 0.05),
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Colors.amber,
                color: const Color(0xFFf6f6f6),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(('x${quantity.toString()} ${foodItem.foodName}'),
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: fontz * 0.7,
                          decoration: TextDecoration.underline,
                          color: Colors.black)),
                  SizedBox(
                    height: plusscreen * 0.05,
                  ),
                  Text(foodItem.foodDesc ?? 'No Name',
                      style: GoogleFonts.roboto(
                          fontSize: fontz * 0.6, color: Colors.grey)),
                  SizedBox(
                    height: plusscreen * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '\$${((foodItem.foodPrice ?? 0.0) * quantity).toStringAsFixed(2)}',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: fontz * 0.7,
                              color: const Color(0xFF7B61FF))),
                      SizedBox(
                        height: plusscreen * 0.15,
                        width: plusscreen * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) {
                                  onUpdateFoodQuantity(foodItem, quantity - 1);
                                } else {
                                  onRemoveFoodItem(foodItem);
                                }
                              },
                              child: Container(
                                width: plusscreen * 0.1,
                                height: plusscreen * 0.1,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFECECED),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: fontz * 0.6,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              quantity.toString().padLeft(2, '0'),
                              style: GoogleFonts.roboto(
                                  fontSize: fontz * 0.6, color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                onUpdateFoodQuantity(foodItem, quantity + 1);
                              },
                              child: Container(
                                width: plusscreen * 0.1,
                                height: plusscreen * 0.1,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFECECED),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: fontz * 0.6,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
