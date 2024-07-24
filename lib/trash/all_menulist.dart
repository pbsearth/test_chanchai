// import 'package:flutter/material.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:test_flutter/trash/foodset_tab.dart';
// import 'package:test_flutter/trash/foodcat_tab.dart';
// import 'package:test_flutter/trash/food_grid.dart';
// import 'package:test_flutter/trash/order.dart';
// import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

// class AllMenu2 extends StatefulWidget {
//   final List<Food> foodList;
//   final List<FoodSet> foodSets;
//   final List<FoodCategory> foodcat;
//   final Function(Food) onFoodSelected;

//   const AllMenu2({
//     super.key,
//     required this.foodList,
//     required this.foodSets,
//     required this.onFoodSelected,
//     required this.foodcat,
//   });

//   @override
//   State<AllMenu2> createState() => _AllMenuState();
// }

// class _AllMenuState extends State<AllMenu2>
//     with SingleTickerProviderStateMixin {
//   List<String> selectedFoodIds = [];
//   List<Food> selectedFoodItems = [];
//   int selectedIndex3 = -1;
//   String selectedSetId = '';
//   String selectedFoodCatId = '';
//   String searchQuery = '';

//   final ItemScrollController _scrollController = ItemScrollController();
//   final ItemPositionsListener _itemPositionsListener =
//       ItemPositionsListener.create();
//   late ScrollController categoryScrollController;

//   @override
//   void initState() {
//     super.initState();
//     selectedSetId = widget.foodSets.first.foodSetId.toString();
//     selectedFoodCatId = groupFoodByCategory(filterFoodList()).keys.first;

//     categoryScrollController = ScrollController();
//     _itemPositionsListener.itemPositions.addListener(_onScrollPositionChanged);
//   }

//   @override
//   void dispose() {
//     _itemPositionsListener.itemPositions
//         .removeListener(_onScrollPositionChanged);
//     categoryScrollController.dispose();
//     super.dispose();
//   }

//   void _onScrollPositionChanged() {
//     final itemPositions = _itemPositionsListener.itemPositions.value;

//     if (itemPositions.isEmpty) return;

//     final firstVisibleItem = itemPositions.first;

//     if (firstVisibleItem.index < 0) return;

//     final categoryNames = groupFoodByCategory(filterFoodList()).keys.toList();
//     final visibleCategoryName = categoryNames[firstVisibleItem.index];

//     if (selectedFoodCatId != visibleCategoryName) {
//       setState(() {
//         selectedFoodCatId = visibleCategoryName;
//       });
//     }
//   }

//   void _scrollToCategory(String categoryName) {
//     final foodList = filterFoodList();
//     final groupedFood = groupFoodByCategory(foodList);

//     final index = groupedFood.keys.toList().indexOf(categoryName);
//     if (index != -1) {
//       _scrollController.scrollTo(
//           index: index, duration: const Duration(milliseconds: 300));
//     }
//   }

//   void onFoodTap(Food food) {
//     final foodId = food.foodId.toString();

//     setState(() {
//       if (food.isOutStock == false) {
//         selectedFoodIds.add(foodId);
//         selectedFoodItems.add(food);
//         widget.onFoodSelected(food);
//         selectedIndex3 = selectedFoodIds.indexOf(foodId);
//       } else {
//         print('${food.foodName} is Sold Out');
//       }
//     });
//   }

//   List<Food> filterFoodList() {
//     final filteredList = widget.foodList.where((food) {
//       final matchesSetId = food.foodSetId == selectedSetId;
//       final matchesSearchQuery = searchQuery.isEmpty ||
//           (food.foodName?.toLowerCase().contains(searchQuery.toLowerCase()) ??
//               false);
//       return matchesSetId && matchesSearchQuery;
//     }).toList();
//     return filteredList;
//   }

//   Map<String, List<Food>> groupFoodByCategory(List<Food> foodList) {
//     final Map<String, List<Food>> groupedFood = {};
//     final Map<String, String> foodCatMap = {};
//     final Map<String, int> foodCatSortingMap = {};

//     for (var foodCat in widget.foodcat) {
//       if (foodCat.active!) {
//         foodCatMap[foodCat.foodCatId!] = foodCat.foodCatName!;
//         foodCatSortingMap[foodCat.foodCatId!] = foodCat.foodCatSorting ?? 0;
//       }
//     }

//     for (var food in foodList) {
//       if (foodCatMap.containsKey(food.foodCatId)) {
//         final foodCatName = foodCatMap[food.foodCatId]!;
//         groupedFood.putIfAbsent(foodCatName, () => []).add(food);
//       }
//     }

//     final sortedCategoryNames = foodCatSortingMap.entries
//         .where((entry) => groupedFood.containsKey(foodCatMap[entry.key]))
//         .toList()
//       ..sort((a, b) => a.value.compareTo(b.value));

//     final sortedGroupedFood = <String, List<Food>>{};
//     for (var entry in sortedCategoryNames) {
//       final categoryName = foodCatMap[entry.key]!;
//       sortedGroupedFood[categoryName] = groupedFood[categoryName]!;
//     }

//     return sortedGroupedFood;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     double plusscreen = (screenHeight + screenWidth) * 0.1;
//     final foodList = filterFoodList();
//     final groupedFood = groupFoodByCategory(foodList);

//     return Column(
//       children: [
//         FoodSetList(
//           foodSets: widget.foodSets,
//           selectedSetId: selectedSetId,
//           onSetSelected: (setId) {
//             setState(() {
//               selectedSetId = setId;
//             });
//           },
//         ),
//         FoodCategoryList(
//           groupedFood: groupedFood,
//           selectedFoodCatId: selectedFoodCatId,
//           onCategorySelected: (categoryId) {
//             setState(() {
//               selectedFoodCatId = categoryId;
//               _scrollToCategory(categoryId);
//             });
//           },
//         ),
//         Expanded(
//           child: OrientationBuilder(
//             builder: (context, orientation) {
//               return ResponsiveSizer(
//                 builder: (context, orientation, screenType) {
//                   return Expanded(
//                     child: FoodGrid(
//                       scrollController: _scrollController,
//                       itemPositionsListener: _itemPositionsListener,
//                       groupedFood: groupedFood,
//                       onFoodTap: onFoodTap,
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
