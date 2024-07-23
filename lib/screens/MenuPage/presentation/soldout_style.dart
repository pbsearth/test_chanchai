import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OutOfStockOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.2.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        color: Colors.white.withOpacity(0.5),
      ),
      alignment: Alignment.center,
      child: Text(
        'Sold Out',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
