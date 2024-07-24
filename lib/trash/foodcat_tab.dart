// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

// class FoodCategoryList extends StatelessWidget {
//   final Map<String, List<Food>> groupedFood;
//   final String selectedFoodCatId;
//   final Function(String) onCategorySelected;

//   FoodCategoryList({
//     Key? key,
//     required this.groupedFood,
//     required this.selectedFoodCatId,
//     required this.onCategorySelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // double screenHeight = MediaQuery.of(context).size.height;
//     // double screenWidth = MediaQuery.of(context).size.width;
//     // double plusscreen = (screenHeight + screenWidth) * 0.1;

//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: const Color(0xFFF6F6F6),
//       ),
//       // color: Colors.amber,
//       height: 8.h,
//       // width: 30.w,
//       padding: EdgeInsets.only(top: 0.h, left: 1.w, right: 1.w, bottom: 0.1.h),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: groupedFood.keys.length,
//         itemBuilder: (context, index) {
//           final categoryName = groupedFood.keys.elementAt(index);
//           final isSelected = categoryName == selectedFoodCatId;

//           return GestureDetector(
//             onTap: () => onCategorySelected(categoryName),
//             child: Container(
//               margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 0.2.w),
//               padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.5.w),
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? const Color(0xFF02CCFE)
//                     : const Color(0xFFF6F6F6),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Center(
//                 child: Text(
//                   categoryName,
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     fontWeight: FontWeight.bold,
//                     color: isSelected ? Colors.white : Color(0xFFACACAC),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
