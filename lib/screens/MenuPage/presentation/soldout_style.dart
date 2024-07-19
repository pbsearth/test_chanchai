import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OutOfStockOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.5),
      ),
      alignment: Alignment.center,
      child: Text(
        'Sold Out',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
