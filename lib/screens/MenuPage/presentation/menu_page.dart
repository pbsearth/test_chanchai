import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:test_flutter/screens/MenuPage/widgets/foodlist.dart';
import 'package:test_flutter/screens/bloc/bloc_foodlist/foodlist_bloc.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedIndex = 0;
  int selectedIndex2 = 0;
  int selectedIndex3 = -1;
  List<String> selectedFoodIds = [];
  List<Food> selectedFoodItems = [];
  Map<String, int> foodQuantities = {};
  List<FoodSet> foodSet = [];

  final TextEditingController textController = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   print(foodSet.toString());
  // }

  @override
  Widget build(BuildContext context) {
    final foodBloc = BlocProvider.of<FoodBloc>(context);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen = screenHeight + screenWidth;

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
              List<Food> foodList = state.foodList;
              List<FoodSet> foodSets = state.foodSetList;
              List<FoodCategory> foodCats = state.foodCategoryList;

              print(foodSet.toString());

              return Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
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
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: foodSets.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: selectedIndex == index
                                          ? const Color(0xFF02ccfe)
                                          : const Color(0xFFf6f6f6),
                                    ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(state
                                              .foodSetList[index].foodSetName
                                              .toString()),
                                          // เพิ่ม Widget อื่น ๆ ที่คุณต้องการแสดงในแต่ละ Row ได้ตามต้องการ
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: foodCats.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex2 = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: selectedIndex2 == index
                                          ? const Color(0xFF02ccfe)
                                          : const Color(0xFFf6f6f6),
                                    ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(state.foodCategoryList[index]
                                              .foodCatName
                                              .toString()),
                                          // เพิ่ม Widget อื่น ๆ ที่คุณต้องการแสดงในแต่ละ Row ได้ตามต้องการ
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: AllMenu(
                            foodList: foodList,
                            onFoodSelected: (selectedFood) {
                              setState(() {
                                final foodId = selectedFood.foodId.toString();
                                if (selectedFoodItems.contains(selectedFood)) {
                                } else {
                                  selectedFoodIds.add(foodId);
                                  selectedFoodItems.add(selectedFood);
                                  foodQuantities[foodId] = 1;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    width: 2,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
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
                        Container(
                          height: screenHeight * 0.65,
                          width: double.infinity,
                          color: Color.fromARGB(255, 178, 248, 214),
                          child: SingleChildScrollView(
                            child: buildSelectedFoodList(),
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Subtotal',
                                          style: GoogleFonts.workSans(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '\$0.00',
                                          style: GoogleFonts.workSans(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ]),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    width: double.infinity,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                        Text('(${selectedFoodItems.length})',
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
                  ),
                ],
              );
            } else if (state is FoodError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            }
            return Container();
          },
        ));
  }

  Widget buildSelectedFoodList() {
    if (selectedFoodItems.isEmpty) {
      return SizedBox.shrink(); // Return an empty SizedBox if no items selected
    }

    List<Widget> selectedFoodsWidgets = selectedFoodItems.map((foodItem) {
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
                        '\$${foodItem.foodPrice}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF836afe),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
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
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: selectedFoodsWidgets,
          ),
        ],
      ),
    );
  }

  Widget buildfoodSet(String text, int index) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen = screenHeight + screenWidth;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: plusscreen * 0.005, horizontal: plusscreen * 0.01),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selectedIndex == index
              ? const Color(0xFF02ccfe)
              : const Color(0xFFf6f6f6),
          border: Border.all(
              color: selectedIndex == index
                  ? Colors.black
                  : const Color(0xFFf6f6f6),
              width: 0.5),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: selectedIndex == index
                  ? Colors.white
                  : const Color(0xFF7b7b7b),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildfoodCategory(String text, int index) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen = screenHeight + screenWidth;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex2 = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: plusscreen * 0.005, horizontal: plusscreen * 0.005),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selectedIndex2 == index
              ? const Color(0xFF02ccfe)
              : const Color(0xFFf6f6f6),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: selectedIndex2 == index
                  ? Colors.white
                  : const Color(0xFF7b7b7b),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
