import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:test_flutter/screens/bloc/bloc_foodlist/foodlist_bloc.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedIndex = 0;
  int selectedIndex2 = 0;
  int selectedIndex3 = -1; // Initial index to none selected
  Set<String> selectedFoodIds = {}; // Set to store selected foodIds

  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen = screenHeight + screenWidth;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        AnimSearchBar(
                          width: MediaQuery.of(context).size.width * 0.4,
                          textController: textController,
                          onSuffixTap: () {},
                          onSubmitted: (String search) {},
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    child: Row(
                      children: [
                        buildfoodSet('Thai Menu', 0),
                        buildfoodSet('Japanese Menu', 1),
                        buildfoodSet('Bar Menu', 2),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    child: Row(
                      children: [
                        buildfoodCategory('Appetizers', 0),
                        buildfoodCategory('Soups', 1),
                        buildfoodCategory('Salads', 2),
                        buildfoodCategory('Noodles', 3),
                        buildfoodCategory('Entrees', 4),
                        buildfoodCategory('Rice Dishes', 5),
                        buildfoodCategory('Side Orders', 6),
                        buildfoodCategory('Drinks', 7),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<FoodBloc, FoodState>(
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
                      return Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > constraints.maxHeight) {
                              return ListView.builder(
                                itemCount: (state.foodList.length / 4).ceil(),
                                itemBuilder: (context, rowIndex) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                      4,
                                      (colIndex) {
                                        final index = rowIndex * 4 + colIndex;
                                        if (index < state.foodList.length) {
                                          final foodId =
                                              state.foodList[index].foodId;
                                          final isSelected =
                                              selectedFoodIds.contains(foodId);

                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (isSelected) {
                                                  selectedFoodIds
                                                      .remove(foodId);
                                                } else {
                                                  selectedFoodIds
                                                      .add(foodId.toString());
                                                }
                                                // Toggle selection
                                                selectedIndex3 =
                                                    isSelected ? -1 : index;
                                              });
                                              // Print food name
                                              print(state
                                                      .foodList[index].foodId ??
                                                  'No Name');
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: plusscreen * 0.0005,
                                                vertical: plusscreen * 0.002,
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: screenHeight * 0.15,
                                                    width: screenWidth * 0.15,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .vertical(
                                                        top:
                                                            Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                        color: isSelected
                                                            ? const Color(
                                                                0xFF02ccfe) // Selected border color
                                                            : Colors
                                                                .transparent, // Default border color
                                                        width: 3,
                                                      ),
                                                      image: state
                                                                      .foodList[
                                                                          index]
                                                                      .imageName !=
                                                                  null &&
                                                              state
                                                                  .foodList[
                                                                      index]
                                                                  .imageName!
                                                                  .isNotEmpty
                                                          ? DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                state
                                                                    .foodList[
                                                                        index]
                                                                    .imageName!,
                                                              ),
                                                              fit: BoxFit.cover,
                                                            )
                                                          : const DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/image/noimage2.jpg'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: isSelected
                                                          ? const Color(
                                                              0xFF02ccfe)
                                                          // Selected border color
                                                          : Colors.amberAccent,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .vertical(
                                                        bottom:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    height: screenHeight * 0.05,
                                                    width: screenWidth * 0.15,
                                                    child: Center(
                                                      child: Text(
                                                        state.foodList[index]
                                                                .foodName ??
                                                            'No Name',
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return SizedBox(
                                            width: plusscreen * 0.1,
                                          ); // Spacer for empty cell
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                            } else {
                              return ListView.builder(
                                itemCount: (state.foodList.length / 2).ceil(),
                                itemBuilder: (context, rowIndex) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                      2,
                                      (colIndex) {
                                        final index = rowIndex * 2 + colIndex;
                                        if (index < state.foodList.length) {
                                          final foodId =
                                              state.foodList[index].foodId;
                                          final isSelected =
                                              selectedFoodIds.contains(foodId);

                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (isSelected) {
                                                  selectedFoodIds
                                                      .remove(foodId);
                                                } else {
                                                  selectedFoodIds
                                                      .add(foodId.toString());
                                                }
                                                // Toggle selection
                                                selectedIndex3 =
                                                    isSelected ? -1 : index;
                                              });
                                              // Print food name
                                              print(state.foodList[index]
                                                      .foodName ??
                                                  'No Name');
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: plusscreen * 0.0005,
                                                vertical: plusscreen * 0.002,
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: screenHeight * 0.2,
                                                    width: screenWidth * 0.3,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .vertical(
                                                        top:
                                                            Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                        color: isSelected
                                                            ? Colors
                                                                .blue // Selected border color
                                                            : Colors
                                                                .transparent, // Default border color
                                                        width: 3,
                                                      ),
                                                      image: state
                                                                      .foodList[
                                                                          index]
                                                                      .imageName !=
                                                                  null &&
                                                              state
                                                                  .foodList[
                                                                      index]
                                                                  .imageName!
                                                                  .isNotEmpty
                                                          ? DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                state
                                                                    .foodList[
                                                                        index]
                                                                    .imageName!,
                                                              ),
                                                              fit: BoxFit.cover,
                                                            )
                                                          : const DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/image/noimage2.jpg'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.amberAccent,
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        bottom:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    height: screenHeight * 0.05,
                                                    width: screenWidth * 0.3,
                                                    child: Center(
                                                      child: Text(
                                                        state.foodList[index]
                                                                .foodName ??
                                                            'No Name',
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return SizedBox(
                                            width: plusscreen * 0.1,
                                          ); // Spacer for empty cell
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      );
                    } else if (state is FoodError) {
                      return Center(
                        child: Text('Error: ${state.message}'),
                      );
                    }
                    return Container();
                  },
                )
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
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.all(20),
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
                                fontWeight: FontWeight.bold, fontSize: 16),
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
                      )
                    ],
                  ),
                  Padding(
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
                                '\$0.00',
                                style: GoogleFonts.workSans(
                                    fontWeight: FontWeight.w500),
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
                                color: Colors.grey),
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
                                Text('(0)',
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
                  )
                ],
              )),
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
