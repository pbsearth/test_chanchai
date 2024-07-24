import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/screens/MenuPage/widgets/food_tab.dart';
import 'package:test_flutter/screens/MenuPage/widgets/order.dart';
import 'package:test_flutter/screens/MenuPage/widgets/search_grid.dart';
import 'package:test_flutter/screens/bloc/bloc_foodlist/foodlist_bloc.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedIndex = 0;
  List<String> selectedFoodIds = [];
  List<Food> selectedFoodItems = [];
  Map<String, int> foodQuantities = {};
  bool _isSearchExpanded = false;
  double subtotal = 0.0;
  int countorder = 0;
  List<Food> filteredFoodList = [];
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      _onSearchChanged(textController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen = (screenHeight + screenWidth) * 0.1;
    double fontz = plusscreen * 0.1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodInitial) {
            return const Center(
              child: Text('Press button to fetch food data'),
            );
          } else if (state is FoodLoading) {
            return SizedBox(
              width: double.infinity,
              height: screenHeight * 0.5,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF02ccfe),
                ),
              ),
            );
          } else if (state is FoodSuccess) {
            return buildSuccessState(
                context, state, screenHeight, screenWidth, plusscreen, fontz);
          } else if (state is FoodError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildSuccessState(
      BuildContext context,
      FoodSuccess state,
      double screenHeight,
      double screenWidth,
      double plusscreen,
      double fontz) {
    // final currentFoodList =
    //     textController.text.isEmpty ? state.foodList : filteredFoodList;

    return OrientationBuilder(builder: (context, orientation) {
      return Row(
        children: [
          Expanded(
            flex: orientation == Orientation.portrait ? 8 : 35,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTopRow(screenWidth, screenHeight, plusscreen, fontz),
                  Expanded(
                    flex: 6,
                    child: textController.text.isEmpty
                        ? AllMenu(
                            // foodList: state.foodList,
                            // foodSets: state.foodSetList,
                            // foodcat: state.foodCategoryList,
                            onFoodSelected: onFoodSelected,
                          )
                        : SearchResultsGrid(
                            filteredFoodList: filteredFoodList,
                            onFoodSelected: onFoodSelected,
                          ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(
            width: 1,
            thickness: 1,
            color: Colors.grey,
          ),
          Expanded(
            flex: orientation == Orientation.portrait ? 4 : 9,
            child: OrderSummary(
              selectedFoodItems: selectedFoodItems,
              foodQuantities: foodQuantities,
              subtotal: subtotal,
              countorder: countorder,
              onRemoveFoodItem: (Food foodItem) {
                _onRemoveFoodItem(foodItem.foodId.toString());
              },
              onUpdateFoodQuantity: (Food foodItem, int quantity) {
                _onUpdateFoodQuantity(foodItem, quantity);
              },
            ),
          ),
        ],
      );
    });
  }

  Widget buildTopRow(double screenWidth, double screenHeight, double plusscreen,
      double fontz) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildBackButton(screenWidth, screenHeight, plusscreen, fontz),
        buildSearchBar(screenWidth, screenHeight, plusscreen, fontz),
      ],
    );
  }

  Widget buildBackButton(double screenWidth, double screenHeight,
      double plusscreen, double fontz) {
    return Padding(
      padding: EdgeInsets.fromLTRB(plusscreen * 0.1, plusscreen * 0.07, 0, 0),
      child: Container(
        width: plusscreen * 0.4,
        height: plusscreen * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFF6F6F6)),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_ios_new_rounded,
                size: fontz * 1,
                color: const Color(0xFF7b7b7b),
              ),
              Text(
                'Back',
                style: TextStyle(
                    fontSize: fontz * 0.8,
                    color: const Color(0xFF7b7b7b),
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar(double screenWidth, double screenHeight,
      double plusscreen, double fontz) {
    return Padding(
      padding: EdgeInsets.fromLTRB(2, plusscreen * 0.07, plusscreen * 0.1, 0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _isSearchExpanded ? screenWidth * 0.4 : plusscreen * 0.2,
        height: plusscreen * 0.2,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (_isSearchExpanded) {
                    textController.clear();
                    _onSearchChanged('');
                  }
                  _isSearchExpanded = !_isSearchExpanded;
                });
              },
              child: SizedBox(
                width: plusscreen * 0.2,
                child: SvgPicture.asset(
                  'assets/svg/search_icon.svg',
                  height: plusscreen * 0.1,
                  width: plusscreen * 0.1,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: plusscreen * 0.2,
                constraints: BoxConstraints(
                  minHeight: plusscreen * 0.2,
                  maxHeight: plusscreen * 0.2,
                ),
                child: _isSearchExpanded
                    ? TextField(
                        controller: textController,
                        onChanged: (query) {
                          setState(() {
                            _onSearchChanged(query);
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          hintText: 'Search',
                          hintStyle: GoogleFonts.roboto(
                              fontSize: fontz * 0.8,
                              color: const Color(0xFF7b7b7b),
                              fontWeight: FontWeight.w500),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: screenWidth * 0.01),
                        ),
                        style: GoogleFonts.roboto(fontSize: fontz * 0.8),
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onFoodSelected(Food selectedFood) {
    final foodId = selectedFood.foodId.toString();
    if (!selectedFoodIds.contains(foodId)) {
      setState(() {
        selectedFoodIds.add(foodId);
        selectedFoodItems.add(selectedFood);
        foodQuantities[foodId] = 1;
        calculateSubtotal();
        order();
      });
    } else {
      print('Food with ID $foodId is already selected.');
    }
  }

  void calculateSubtotal() {
    subtotal = 0.0;

    for (var food in selectedFoodItems) {
      final foodId = food.foodId.toString();
      final quantity = foodQuantities[foodId] ?? 0;
      subtotal += (food.foodPrice ?? 0.0) * quantity;
    }
  }

  void order() {
    countorder = 0;
    for (var food in selectedFoodItems) {
      final foodId = food.foodId.toString();
      final quantity = foodQuantities[foodId] ?? 0;
      countorder += quantity;
    }
  }

  void _onSearchChanged(String query) {
    final allFoodList =
        (context.read<FoodBloc>().state as FoodSuccess).foodList;
    setState(() {
      filteredFoodList = allFoodList
          .where((food) =>
              food.foodName?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  void _onRemoveFoodItem(String foodId) {
    setState(() {
      selectedFoodIds.remove(foodId);
      selectedFoodItems.removeWhere((food) => food.foodId.toString() == foodId);
      foodQuantities.remove(foodId);
      _updateSubtotalAndOrderCount();
    });
  }

  void _onUpdateFoodQuantity(Food foodItem, int quantity) {
    setState(() {
      foodQuantities[foodItem.foodId.toString()] = quantity;
      _updateSubtotalAndOrderCount();
    });
  }

  void _updateSubtotalAndOrderCount() {
    subtotal = 0.0;
    countorder = 0;

    for (var food in selectedFoodItems) {
      final foodId = food.foodId.toString();
      final quantity = foodQuantities[foodId] ?? 0;
      subtotal += (food.foodPrice ?? 0.0) * quantity;
      countorder += quantity;
    }
  }
}
