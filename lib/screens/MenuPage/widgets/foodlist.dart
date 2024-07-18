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
  // late TabController _tabController;
  List<String> selectedFoodIds = [];
  List<Food> selectedFoodItems = [];
  int selectedIndex3 = -1;
  String selectedSetId = '';
  String selectedFoodCatId = '';

  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: widget.foodSets.length, vsync: this);
    selectedSetId = widget.foodSets.first.foodSetId.toString();

    selectedFoodCatId = widget.foodcat.first.foodCatName!;
    selectedFoodCatId = groupFoodByCategory2(filterFoodList()).keys.first;
  }

  void onFoodTap(Food food) {
    final foodId = food.foodId.toString();

    if (!selectedFoodIds.contains(foodId)) {
      setState(() {
        selectedFoodIds.add(foodId);
        selectedFoodItems.add(food);
        widget.onFoodSelected(food);
        selectedIndex3 = selectedFoodIds.indexOf(foodId);
      });
      print('add');
    }
  }

  List<Food> filterFoodList() {
    return widget.foodList.where((food) {
      final matchesSetId = food.foodSetId == selectedSetId;
      return matchesSetId;
    }).toList();
  }

  Map<String, List<Food>> groupFoodByCategory2(List<Food> foodList) {
    final Map<String, List<Food>> groupedFood2 = {};

    final Map<String, String> foodCatMap = {};
    for (var foodCat in widget.foodcat) {
      foodCatMap[foodCat.foodCatId!] = foodCat.foodCatName!;
    }

    for (var food in foodList) {
      if (foodCatMap.containsKey(food.foodCatId)) {
        final foodCatName = foodCatMap[food.foodCatId]!;
        groupedFood2.putIfAbsent(foodCatName, () => []).add(food);
      }
    }

    return groupedFood2;
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen = (screenHeight + screenWidth) * 0.1;
    final foodList = filterFoodList();
    final groupedFood2 = groupFoodByCategory2(foodList);
    ScrollController categoryScrollController = ScrollController();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(plusscreen * 0.02),
          height: plusscreen * 0.25,
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
                  margin: EdgeInsets.only(right: 1.w),
                  padding: EdgeInsets.symmetric(horizontal: plusscreen * 0.1),
                  decoration: BoxDecoration(
                    color: selectedSetId == foodSet.foodSetId.toString()
                        ? const Color(0xFF02CCFE)
                        : const Color(0xFFF6F6F6),
                    border: Border.all(
                        color: selectedSetId == foodSet.foodSetId.toString()
                            ? Colors.black
                            : Colors.transparent,
                        width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    foodSet.foodSetName.toString(),
                    style: TextStyle(
                      fontSize: plusscreen * 0.07,
                      fontWeight: FontWeight.bold,
                      color: selectedSetId == foodSet.foodSetId.toString()
                          ? Colors.white
                          : const Color(0xFFACACAC),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(plusscreen * 0.02),
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
                  margin: EdgeInsets.only(right: 1.w),
                  padding: EdgeInsets.symmetric(horizontal: plusscreen * 0.1),
                  decoration: BoxDecoration(
                    color: selectedFoodCatId == foodCategory
                        ? const Color(0xFF02CCFE)
                        : const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    foodCategory,
                    style: TextStyle(
                      fontSize: plusscreen * 0.055,
                      fontWeight: FontWeight.bold,
                      color: selectedFoodCatId == foodCategory
                          ? Colors.white
                          : const Color(0xFFACACAC),
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

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              foodCatName,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  orientation == Orientation.landscape ? 4 : 2,
                              childAspectRatio:
                                  (orientation == Orientation.landscape
                                          ? 22.w
                                          : 45.w) /
                                      (orientation == Orientation.landscape
                                          ? 40.h
                                          : 30.h),
                              mainAxisSpacing: 1.h,
                              crossAxisSpacing: 1.w,
                            ),
                            itemCount: foodItems.length,
                            itemBuilder: (context, index) {
                              final food = foodItems[index];

                              return GestureDetector(
                                onTap: () => onFoodTap(food),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.w, vertical: 1.h),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: orientation ==
                                                  Orientation.landscape
                                              ? 42.h
                                              : 30.h,
                                          width: orientation ==
                                                  Orientation.landscape
                                              ? 22.w
                                              : 45.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 5,
                                                offset: Offset(1, 5),
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
                                                  : 30.h) -
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
                                                          Orientation.landscape
                                                      ? 35.h
                                                      : 30.h) -
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
                                                color: Colors.grey[300],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Sold Out',
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 5.h,
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
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(5),
                                            ),
                                          ),
                                          height: 18.h,
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
                                                    fontSize: 2.5.h,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 4.h,
                                                child: Text(
                                                  food.foodDesc!,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 2.h,
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
                                                      fontSize: 3.h,
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
                                                      fontSize: 3.h,
                                                      fontWeight:
                                                          FontWeight.bold,
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
