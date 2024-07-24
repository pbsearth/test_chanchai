// import 'package:flutter/material.dart';
// import 'package:test_flutter/trash/soldout_style.dart';
// import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class FoodItem extends StatelessWidget {
//   final Food food;
//   final Function(Food) onFoodTap;

//   FoodItem({
//     Key? key,
//     required this.food,
//     required this.onFoodTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onFoodTap(food),
//       child: Stack(
//         children: [
//           Container(
//             height: 45.h,
//             width: double.infinity,
//             // margin: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 1.h),
//             // padding: EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey, width: 0.5),
//                 color: Colors.amber,
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 2,
//                     blurStyle: BlurStyle.inner,
//                     offset: Offset(0, 5.0),
//                   ),
//                 ]),
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius:
//                       const BorderRadius.vertical(top: Radius.circular(9)),
//                   child: Image.network(
//                     food.imageName ?? '',
//                     height: 26.h,
//                     width: double.infinity, // width: 60.sp,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 // SizedBox(height: 8.0),
//                 Container(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.5.h),
//                   height: 18.3.h,
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     borderRadius:
//                         BorderRadius.vertical(bottom: Radius.circular(9)),
//                   ),
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         top: 0,
//                         left: 0,
//                         child: Text(
//                           food.foodName ?? '',
//                           style: TextStyle(
//                             fontSize: 12.5.sp,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           maxLines: 1,
//                         ),
//                       ),
//                       Positioned(
//                         top: 4.h,
//                         left: 0,
//                         child: Text(food.foodDesc ?? '',
//                             style: TextStyle(
//                               fontSize: 11.sp,
//                               color: Colors.grey,
//                             ),
//                             maxLines: 3),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         left: 0,
//                         child: Text(
//                           ('\$${food.foodPrice.toString()}'),
//                           style: TextStyle(
//                             fontSize: 12.5.sp,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (food.isOutStock == true) OutOfStockOverlay(),
//         ],
//       ),
//     );
//   }
// }
