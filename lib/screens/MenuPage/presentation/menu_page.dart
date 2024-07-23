import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/screens/MenuPage/widgets/foodlist.dart';
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
                context, state, screenHeight, screenWidth, plusscreen);
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

  Widget buildSuccessState(BuildContext context, FoodSuccess state,
      double screenHeight, double screenWidth, double plusscreen) {
    if (filteredFoodList.isEmpty) {
      filteredFoodList = state.foodList;
    }
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTopRow(screenWidth, screenHeight, plusscreen),
                Expanded(
                  flex: 6,
                  child: AllMenu(
                    foodList: filteredFoodList,
                    foodSets: state.foodSetList,
                    foodcat: state.foodCategoryList,
                    onFoodSelected: onFoodSelected,
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalDivider(
          width: 2,
          thickness: 1,
          color: Colors.black,
        ),
        buildOrderSummary(screenHeight),
      ],
    );
  }

  Widget buildTopRow(
      double screenWidth, double screenHigth, double plusscreen) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildBackButton(),
        buildSearchBar(screenWidth, screenHigth, plusscreen),
      ],
    );
  }

  Widget buildBackButton() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 20, 0, 10),
      width: 70,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Color(0xFF7b7b7b),
            ),
            Text(
              'Back',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF7b7b7b),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar(
      double screenWidth, double sceenHigth, double plusscreen) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isSearchExpanded ? screenWidth * 0.4 : plusscreen * 0.2,
      height: plusscreen * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      alignment: _isSearchExpanded ? Alignment.center : Alignment.center,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              padding: const EdgeInsets.all(5),
              icon: Icon(
                _isSearchExpanded ? Icons.close : Icons.search,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  if (_isSearchExpanded) {
                    textController.clear();
                    _onSearchChanged('');
                  }
                  _isSearchExpanded = !_isSearchExpanded;
                });
              },
            ),
          ),
          //  InkWell(
          //       onTap: () {
          //         setState(() {
          //           if (_isSearchExpanded) {
          //             textController.clear();
          //             _onSearchChanged('');
          //           }
          //           _isSearchExpanded = !_isSearchExpanded;
          //         });
          //       },
          //       child: SvgPicture.asset('assets/svg/search_icon.svg'),
          //     ),
          Expanded(
            child: _isSearchExpanded
                ? TextField(
                    controller: textController,
                    onChanged: (query) {
                      setState(() {
                        _onSearchChanged(query);
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 16),
                  )
                : Container(),
          ),
        ],
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
    setState(() {
      filteredFoodList = (context.read<FoodBloc>().state as FoodSuccess)
          .foodList
          .where((food) =>
              food.foodName?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  Widget buildOrderSummary(double screenHeight) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: screenHeight * 0.15,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    height: 20,
                    width: 20,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/image/flag_usa.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'My Order',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.edit_square,
                      size: 15,
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(),
                ),
              ],
            ),
          ),
          if (countorder == 0) Text('No order selected'),
          Container(
            height: screenHeight * 0.65,
            width: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: buildSelectedFoodList(),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: GoogleFonts.workSans(
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '\$${subtotal.toStringAsFixed(2)}',
                            style: GoogleFonts.workSans(
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selectedFoodItems.isNotEmpty
                            ? const Color(0xFF32CD32)
                            : const Color(0xFF8D8D8D),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.shopping_cart_outlined,
                            size: 15,
                            color: Colors.white,
                          ),
                          Text('Confirm Order',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white)),
                          Text('($countorder)',
                              style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectedFoodList() {
    if (selectedFoodItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: selectedFoodItems.map(
        (foodItem) {
          final foodId = foodItem.foodId.toString();
          final quantity = foodQuantities[foodId] ?? 0;

          return Padding(
            padding: const EdgeInsets.all(5),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFf6f6f6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(
                      foodItem.foodName ?? 'No Name',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${((foodItem.foodPrice ?? 0.0) * quantity).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF836afe),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            width: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (foodQuantities[foodId]! > 1) {
                                        foodQuantities[foodId] =
                                            foodQuantities[foodId]! - 1;
                                      } else {
                                        selectedFoodIds.remove(foodId);
                                        selectedFoodItems.remove(foodItem);
                                        foodQuantities.remove(foodId);
                                      }
                                      calculateSubtotal();
                                      order();
                                    });
                                  },
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    color: Colors.redAccent,
                                    child: const Icon(
                                      Icons.remove,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                Text(quantity.toString().padLeft(2, '0')),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      foodQuantities[foodId] = quantity + 1;
                                      calculateSubtotal();
                                      order();
                                    });
                                  },
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    color: Colors.greenAccent,
                                    child: const Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFoodIds.remove(foodId);
                        selectedFoodItems.remove(foodItem);
                        foodQuantities.remove(foodId);
                        calculateSubtotal();
                        order();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
