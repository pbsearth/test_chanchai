import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:test_flutter/screens/MenuPage/widgets/foodlist.dart';
import 'package:test_flutter/screens/bloc/bloc_foodlist/foodlist_bloc.dart';
import 'package:test_flutter/screens/domain/domain_foodlist/models/model_food.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuPageNew extends StatefulWidget {
  const MenuPageNew({Key? key}) : super(key: key);

  @override
  State<MenuPageNew> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPageNew> {
  int selectedIndex = 0;
  int selectedIndex2 = 0;
  int selectedIndex3 = -1;
  List<String> selectedFoodIds = [];
  List<Food> selectedFoodItems = [];
  Map<String, int> foodQuantities = {};
  List<FoodSet> foodSet = [];

  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodInitial) {
            return Center(
              child: const Text('Press button to fetch food data'),
            );
          } else if (state is FoodLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF02ccfe),
              ),
            );
          } else if (state is FoodSuccess) {
            List<FoodSet> foodSets = state.foodSetList;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.foodSetList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(state.foodSetList[index].foodSetName.toString()),
                  ],
                );
              },
            );
          } else if (state is FoodError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }
          return Container(); // หรือ Widget ที่ต้องการสำหรับบรรทัดสุดท้ายในฟังก์ชัน build
        },
      ),
    );
  }

  Widget buildLeftSide() {
    final foodBloc = BlocProvider.of<FoodBloc>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(
            child: BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                if (state is FoodSuccess) {
                  List<Food> foodList = state.foodList;
                  List<FoodSet> foodSets = state.foodSetList;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal, // กำหนดเป็นแนวนอน
                    itemCount: foodSets.length,
                    itemBuilder: (context, index) {
                      FoodSet foodSet = foodSets[index];
                      return ListTile(
                        title: Text(foodSet.foodSetName ?? 'No Name'),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRightSide() {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(20),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.edit_square,
                      size: 15,
                    ),
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
                          style:
                              GoogleFonts.workSans(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '\$0.00',
                          style:
                              GoogleFonts.workSans(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 15,
                            color: Colors.white,
                          ),
                          Text(
                            'Confirm Order',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '(0)',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
}
