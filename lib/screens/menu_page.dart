import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedIndex = 0;
  int selectedIndex2 = 0;
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                            width: 70,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFf6f6f6),
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                          width: MediaQuery.of(context).size.width * 0.3,
                          textController: textController,
                          onSuffixTap: () {},
                          onSubmitted: (String) {},
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
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex2 = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
