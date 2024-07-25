import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class OrderSummary extends StatelessWidget {
  final List<Food> selectedFoodItems;
  final Map<String, int> foodQuantities;
  final double subtotal;
  final int countOrder;
  final void Function(Food foodItem, int quantity) onUpdateFoodQuantity;
  final void Function(Food foodItem) onRemoveFoodItem;

  const OrderSummary({
    super.key,
    required this.selectedFoodItems,
    required this.foodQuantities,
    required this.subtotal,
    required this.countOrder,
    required this.onUpdateFoodQuantity,
    required this.onRemoveFoodItem,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = (screenHeight + screenWidth) * 0.1;
    double fontSize = padding * 0.1;

    return Padding(
      padding:
          EdgeInsets.fromLTRB(padding * 0.1, padding * 0.1, padding * 0.1, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, fontSize, padding),
          if (countOrder == 0)
            _buildEmptyOrderMessage(fontSize)
          else
            _buildFoodList(fontSize, padding),
          _buildFooter(fontSize, padding),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double fontSize, double padding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: padding * 0.1),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: padding * 0.12,
              width: padding * 0.12,
              child: ClipOval(
                child: Image.asset(
                  'assets/image/flag_usa.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: padding * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'My Order',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize * 1.2,
                ),
              ),
              SizedBox(width: padding * 0.03),
              Flexible(
                child: SvgPicture.asset(
                  'assets/svg/edit.svg',
                  height: fontSize,
                  width: fontSize,
                ),
              ),
            ],
          ),
          const Divider(thickness: 0.3, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildEmptyOrderMessage(double fontSize) {
    return Expanded(
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          'No order selected',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w300,
            color: Colors.grey,
            fontSize: fontSize * 0.85,
          ),
        ),
      ),
    );
  }

  Widget _buildFoodList(double fontSize, double padding) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: selectedFoodItems.map((foodItem) {
            final foodId = foodItem.foodId.toString();
            final quantity = foodQuantities[foodId] ?? 0;

            return Padding(
              padding: EdgeInsets.symmetric(vertical: padding * 0.03),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: padding * 0.05, vertical: padding * 0.08),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFf6f6f6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'x${quantity.toString()} ${foodItem.foodName}',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize * 0.7,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: padding * 0.05),
                    if (foodItem.foodDesc != null &&
                        foodItem.foodDesc!.isNotEmpty)
                      Text(
                        foodItem.foodDesc!,
                        style: GoogleFonts.roboto(
                          fontSize: fontSize * 0.6,
                          color: Colors.grey,
                        ),
                      ),
                    if (foodItem.foodDesc != null &&
                        foodItem.foodDesc!.isNotEmpty)
                      SizedBox(height: padding * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${((foodItem.foodPrice ?? 0.0) * quantity).toStringAsFixed(2)}',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize * 0.7,
                            color: const Color(0xFF7B61FF),
                          ),
                        ),
                        _buildQuantityControls(
                            foodItem, quantity, fontSize, padding),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildQuantityControls(
      Food foodItem, int quantity, double fontSize, double padding) {
    return SizedBox(
      height: padding * 0.15,
      width: padding * 0.4,
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
            child: _buildQuantityButton(Icons.remove, fontSize),
          ),
          Text(
            quantity.toString().padLeft(2, '0'),
            style: GoogleFonts.roboto(
                fontSize: fontSize * 0.6, color: Colors.black),
          ),
          GestureDetector(
            onTap: () {
              onUpdateFoodQuantity(foodItem, quantity + 1);
            },
            child: _buildQuantityButton(Icons.add, fontSize),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, double fontSize) {
    return Container(
      width: fontSize,
      height: fontSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFECECED),
      ),
      child: Icon(
        icon,
        size: fontSize * 0.6,
        color: Colors.black,
      ),
    );
  }

  Widget _buildFooter(double fontSize, double padding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: padding * 0.05),
      child: Column(
        children: [
          const Divider(thickness: 0.3, color: Colors.black),
          Padding(
            padding: EdgeInsets.only(bottom: padding * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize,
                  ),
                ),
                Text(
                  countOrder != 0
                      ? '\$${subtotal.toStringAsFixed(2)}'
                      : '\$0.00',
                  style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize,
                    color: countOrder != 0
                        ? const Color(0xFF7B61FF)
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: padding * 0.1),
            width: double.infinity,
            height: padding * 0.25,
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
                  height: fontSize * 1.2,
                  width: fontSize * 1.2,
                ),
                Text(
                  'Confirm Order',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize * 0.8,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '($countOrder)',
                  style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize * 0.8,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
