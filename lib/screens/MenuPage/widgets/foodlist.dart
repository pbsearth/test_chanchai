import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class AllMenu extends StatefulWidget {
  final List<Food> foodList;
  final List<FoodSet> foodSets;
  final List<FoodCategory> foodcat;
  final Function(Food) onFoodSelected;

  const AllMenu({
    super.key,
    required this.foodList,
    required this.foodSets,
    required this.onFoodSelected,
    required this.foodcat,
  });

  @override
  State<AllMenu> createState() => _AllMenuState();
}

class _AllMenuState extends State<AllMenu> with SingleTickerProviderStateMixin {
  List<String> selectedFoodIds = [];
  List<Food> selectedFoodItems = [];
  int selectedIndex3 = -1;
  String selectedSetId = '';
  String selectedFoodCatId = '';
  String searchQuery = '';

  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  late ScrollController categoryScrollController;

  @override
  void initState() {
    super.initState();
    selectedSetId = widget.foodSets.first.foodSetId.toString();
    selectedFoodCatId = groupFoodByCategory2(filterFoodList()).keys.first;

    categoryScrollController = ScrollController();
    _itemPositionsListener.itemPositions.addListener(_onScrollPositionChanged);
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions
        .removeListener(_onScrollPositionChanged);
    categoryScrollController.dispose();
    super.dispose();
  }

  void _onScrollPositionChanged() {
    final itemPositions = _itemPositionsListener.itemPositions.value;

    if (itemPositions.isEmpty) return;

    final firstVisibleItem = itemPositions.first;

    if (firstVisibleItem.index < 0) return;

    final categoryNames = groupFoodByCategory2(filterFoodList()).keys.toList();
    final visibleCategoryName = categoryNames[firstVisibleItem.index];

    if (selectedFoodCatId != visibleCategoryName) {
      setState(() {
        selectedFoodCatId = visibleCategoryName;
      });
    }
  }

  void _scrollToCategory(String categoryName) {
    final foodList = filterFoodList();
    final groupedFood2 = groupFoodByCategory2(foodList);

    final index = groupedFood2.keys.toList().indexOf(categoryName);
    if (index != -1) {
      _scrollController.scrollTo(
          index: index, duration: const Duration(milliseconds: 300));
    }
  }

  void onFoodTap(Food food) {
    final foodId = food.foodId.toString();

    setState(() {
      if (food.isOutStock == false) {
        selectedFoodIds.add(foodId);
        selectedFoodItems.add(food);
        widget.onFoodSelected(food);
        selectedIndex3 = selectedFoodIds.indexOf(foodId);
      } else {
        print('${food.foodName} is Sold Out');
      }
    });

    print('add');
  }

  List<Food> filterFoodList() {
    final filteredList = widget.foodList.where((food) {
      final matchesSetId = food.foodSetId == selectedSetId;
      final matchesSearchQuery = searchQuery.isEmpty ||
          (food.foodName?.toLowerCase().contains(searchQuery.toLowerCase()) ??
              false);
      return matchesSetId && matchesSearchQuery;
    }).toList();
    return filteredList;
  }

  Map<String, List<Food>> groupFoodByCategory2(List<Food> foodList) {
    final Map<String, List<Food>> groupedFood2 = {};
    final Map<String, String> foodCatMap = {};
    final Map<String, int> foodCatSortingMap = {};

    for (var foodCat in widget.foodcat) {
      if (foodCat.active!) {
        foodCatMap[foodCat.foodCatId!] = foodCat.foodCatName!;
        foodCatSortingMap[foodCat.foodCatId!] = foodCat.foodCatSorting ?? 0;
      }
    }

    for (var food in foodList) {
      if (foodCatMap.containsKey(food.foodCatId)) {
        final foodCatName = foodCatMap[food.foodCatId]!;
        groupedFood2.putIfAbsent(foodCatName, () => []).add(food);
      }
    }

    final sortedCategoryNames = foodCatSortingMap.entries
        .where((entry) => groupedFood2.containsKey(foodCatMap[entry.key]))
        .toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    final sortedGroupedFood2 = <String, List<Food>>{};
    for (var entry in sortedCategoryNames) {
      final categoryName = foodCatMap[entry.key]!;
      sortedGroupedFood2[categoryName] = groupedFood2[categoryName]!;
    }

    return sortedGroupedFood2;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen = (screenHeight + screenWidth) * 0.1;
    double fontz = plusscreen * 0.1;
    final foodList = filterFoodList();
    final groupedFood2 = groupFoodByCategory2(foodList);

    return Column(
      children: [
        Container(
          margin:
              EdgeInsets.fromLTRB(plusscreen * 0.1, plusscreen * 0.07, 0, 0),
          height: plusscreen * 0.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.foodSets.length,
            itemBuilder: (context, index) {
              final foodSet = widget.foodSets[index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSetId = foodSet.foodSetId.toString();
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: plusscreen * 0.05),
                  padding: EdgeInsets.symmetric(horizontal: plusscreen * 0.13),
                  decoration: BoxDecoration(
                    color: selectedSetId == foodSet.foodSetId.toString()
                        ? const Color(0xFF02CCFE)
                        : const Color(0xFFF6F6F6),
                    border: Border.all(
                        color: selectedSetId == foodSet.foodSetId.toString()
                            ? Colors.black
                            : Colors.transparent,
                        width: 0.2),
                    borderRadius: BorderRadius.circular(fontz * 0.5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    foodSet.foodSetName.toString(),
                    style: TextStyle(
                      fontSize: fontz * 0.8,
                      fontWeight: selectedSetId == foodSet.foodSetId.toString()
                          ? FontWeight.w400
                          : FontWeight.w700,
                      color: selectedSetId == foodSet.foodSetId.toString()
                          ? Colors.white
                          : const Color(0xFF949494),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin:
              EdgeInsets.fromLTRB(plusscreen * 0.1, plusscreen * 0.05, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFF6F6F6),
          ),
          height: plusscreen * 0.2,
          child: ListView.builder(
            controller: categoryScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: groupedFood2.length,
            itemBuilder: (context, index) {
              final foodCategory = groupedFood2.keys.elementAt(index);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFoodCatId = foodCategory;
                    _scrollToCategory(foodCategory);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: plusscreen * 0.13),
                  decoration: BoxDecoration(
                    color: selectedFoodCatId == foodCategory
                        ? const Color(0xFF02CCFE)
                        : const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(fontz * 0.5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    foodCategory,
                    style: TextStyle(
                      fontSize: fontz * 0.63,
                      fontWeight: selectedFoodCatId == foodCategory
                          ? FontWeight.w400
                          : FontWeight.w600,
                      color: selectedFoodCatId == foodCategory
                          ? Colors.white
                          : const Color(0xFF4F4F4F),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: OrientationBuilder(
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
                            child: Text(foodCatName,
                                style: GoogleFonts.roboto(
                                  fontSize: plusscreen * 0.13,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          Container(
                            // color: Colors.amber,
                            margin: EdgeInsets.fromLTRB(plusscreen * 0.1,
                                plusscreen * 0.04, 0, plusscreen * 0.17),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    orientation == Orientation.landscape
                                        ? 4
                                        : 2,
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
                                  margin: EdgeInsets.fromLTRB(0, 0,
                                      plusscreen * 0.02, plusscreen * 0.05),
                                  child: GestureDetector(
                                    onTap: () => onFoodTap(food),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            height: orientation ==
                                                    Orientation.landscape
                                                ? 41.h
                                                : 21.h,
                                            width: orientation ==
                                                    Orientation.landscape
                                                ? 22.w
                                                : 45.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 2,
                                                  offset: Offset(
                                                      0,
                                                      orientation ==
                                                              Orientation
                                                                  .landscape
                                                          ? 13
                                                          : 6),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          top: 0,
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
                                                top: Radius.circular(5),
                                              ),
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
                                                            Orientation
                                                                .landscape
                                                        ? 35.h
                                                        : 24.h) -
                                                    11.h,
                                                width: orientation ==
                                                        Orientation.landscape
                                                    ? 22.w
                                                    : 45.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                    top: Radius.circular(5),
                                                  ),
                                                  color: Colors.grey[300],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Out of Stock',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: fontz * 1.3,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                            padding: EdgeInsets.all(
                                                plusscreen * 0.05),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                bottom: Radius.circular(5),
                                              ),
                                            ),
                                            height: orientation ==
                                                    Orientation.landscape
                                                ? 18.h
                                                : 9.h,
                                            width: orientation ==
                                                    Orientation.landscape
                                                ? 22.w
                                                : 45.w,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  child: Text(
                                                    food.foodName ?? 'No Name',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: fontz * 0.7,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: plusscreen * 0.1,
                                                  child: Text(
                                                    food.foodDesc!,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: fontz * 0.6,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 0.5.h),
                                                if (food.isOutStock == false)
                                                  Positioned(
                                                    bottom: 0,
                                                    child: Text(
                                                      '\$${food.foodPrice.toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: fontz * 0.7,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                if (food.isOutStock == true)
                                                  Positioned(
                                                    bottom: 0,
                                                    child: Text(
                                                      'Sold Out',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: fontz * 0.7,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration: orientation ==
                                                                Orientation
                                                                    .landscape
                                                            ? TextDecoration
                                                                .underline
                                                            : TextDecoration
                                                                .none,
                                                        decorationThickness: 2,
                                                        decorationColor: Colors
                                                            .red, // สีของการตกแต่ง
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
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  height: screenHeight *
                                      0.5, // Adjust height as needed
                                  child: Container(
                                    color: Colors
                                        .transparent, // Optional background color
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
