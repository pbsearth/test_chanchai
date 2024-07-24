import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/screens/MenuPage/widgets/food_grid.dart';
import 'package:test_flutter/screens/bloc/bloc_foodlist/foodlist_bloc.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class AllMenu extends StatefulWidget {
  final Function(Food) onFoodSelected;

  const AllMenu({
    super.key,
    required this.onFoodSelected,
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
    categoryScrollController = ScrollController();
    _itemPositionsListener.itemPositions.addListener(_onScrollPositionChanged);

    // Set default food set ID after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<FoodBloc>().state;
      if (state is FoodSuccess) {
        setState(() {
          selectedSetId = state.foodSetList.isNotEmpty
              ? state.foodSetList.first.foodSetId.toString()
              : '';
        });
        context.read<FoodBloc>().add(FetchFoodDataEvent(
              selectedSetId: selectedSetId,
              searchQuery: searchQuery,
            ));
      }
    });
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

    final state = context.read<FoodBloc>().state;
    if (state is FoodSuccess) {
      final categoryNames = state.groupedFood.keys.toList();
      final visibleCategoryName = categoryNames[firstVisibleItem.index];

      if (selectedFoodCatId != visibleCategoryName) {
        setState(() {
          selectedFoodCatId = visibleCategoryName;
        });
      }
    }
  }

  void _scrollToCategory(String categoryName) {
    final state = context.read<FoodBloc>().state;
    if (state is FoodSuccess) {
      final index = state.groupedFood.keys.toList().indexOf(categoryName);
      if (index != -1) {
        _scrollController.scrollTo(
            index: index, duration: const Duration(milliseconds: 300));
      }
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

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FoodBloc>().state;

    if (state is FoodLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is FoodError) {
      return Center(child: Text('Error: ${state.message}'));
    }

    if (state is FoodSuccess) {
      final groupedFood2 = state.groupedFood;
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      double plusscreen = (screenHeight + screenWidth) * 0.1;
      double fontz = plusscreen * 0.1;

      return Column(
        children: [
          Container(
            margin:
                EdgeInsets.fromLTRB(plusscreen * 0.1, plusscreen * 0.07, 0, 0),
            height: plusscreen * 0.22,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.foodSetList.length,
              itemBuilder: (context, index) {
                final foodSet = state.foodSetList[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSetId = foodSet.foodSetId.toString();
                      context.read<FoodBloc>().add(FetchFoodDataEvent(
                            selectedSetId: selectedSetId,
                            searchQuery: searchQuery,
                          ));
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: plusscreen * 0.05),
                    padding:
                        EdgeInsets.symmetric(horizontal: plusscreen * 0.13),
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
                        fontWeight:
                            selectedSetId == foodSet.foodSetId.toString()
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
                    padding:
                        EdgeInsets.symmetric(horizontal: plusscreen * 0.13),
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
              child: FoodGrid(
            groupedFood2: groupedFood2,
            onFoodTap: widget.onFoodSelected,
            fontz: fontz,
            plusscreen: plusscreen,
            scrollController: _scrollController,
            itemPositionsListener: _itemPositionsListener,
          )),
        ],
      );
    }

    return const SizedBox();
  }
}
