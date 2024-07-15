import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/screens/contact.dart';
import 'package:test_flutter/screens/menu_page.dart';
import 'package:test_flutter/screens/SecoundPage/second_page.dart';

class FirstPageVertical extends StatefulWidget {
  const FirstPageVertical({super.key});

  @override
  State<FirstPageVertical> createState() => _FristPageVerticalState();
}

class _FristPageVerticalState extends State<FirstPageVertical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenHeight = MediaQuery.of(context).size.height;
            double screenWidth = MediaQuery.of(context).size.width;
            double plusscreen = screenHeight + screenWidth;
            double necscreen = screenHeight - screenWidth;
            double fontPlus = plusscreen * 0.1;
            double necscreenabs = necscreen.abs();

            print('screenHeight : ${screenHeight}');
            print('screenWidth : ${screenWidth}');
            print('plusscreen : ${plusscreen}');
            print('necscreen : ${necscreen}');
            print('necscreenabs : ${necscreenabs}');
            print('new : ${screenHeight - necscreenabs}');

            return Stack(
              children: [
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/gif/backgroud_app2.gif',
                        fit: BoxFit.cover,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 10,
                            height: (screenHeight - necscreen) * 0.5,
                            // color: Colors.amber,
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.restaurant,
                                      color: Colors.white,
                                      size: 3 + fontPlus * 0.15,
                                    ),
                                    Text(
                                      'Soi Siam',
                                      style: GoogleFonts.rasa(
                                        fontSize: 3 + fontPlus * 0.15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Restaurant',
                                      style: GoogleFonts.rasa(
                                        fontSize: 3 + fontPlus * 0.15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: plusscreen * 0.015,
                                  height: 10,
                                  // color: Colors.amber,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: SizedBox(
                    height: screenHeight * 0.55,
                    child: Image.asset(
                      'assets/image/vector_backgroud.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: plusscreen * 0.05,
                      // color: Colors.amber,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: plusscreen * 0.01,
                        vertical: plusscreen * 0.01,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ContactBottomsheet(),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const SecondPage(),
                                  transitionDuration:
                                      const Duration(seconds: 0),
                                  maintainState: false,
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 3 + fontPlus * 0.15,
                              width: 3 + fontPlus * 0.15,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/image/flag_usa.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: plusscreen * 0.05,
                    ),
                    Text(
                      'Self-Service',
                      style: GoogleFonts.rasa(
                        fontSize: plusscreen * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Experience.',
                      style: GoogleFonts.rasa(
                        fontSize: plusscreen * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: plusscreen * 0.02,
                    ),
                    Text(
                      'From self-order and self-checkout',
                      style: GoogleFonts.roboto(
                        fontSize: plusscreen * 0.013,
                        color: const Color(0xFF7D7D7D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: plusscreen * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: SvgPicture.asset('assets/svg/credit_card.svg',
                              fit: BoxFit.cover,
                              height: plusscreen * 0.014,
                              width: plusscreen * 0.014),
                        ),
                        SizedBox(
                          width: plusscreen * 0.01,
                        ),
                        Flexible(
                          child: Text(
                            'Accept only Credit Card',
                            style: GoogleFonts.roboto(
                              fontSize: plusscreen * 0.013,
                              color: const Color(0xFFEB5757),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: plusscreen * 0.04,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MenuPage()),
                        );
                      },
                      child: Container(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.45,
                        decoration: BoxDecoration(
                          color: const Color(0xFF496EE2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'Tap to Order',
                            style: GoogleFonts.roboto(
                              fontSize: plusscreen * 0.013,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: fontPlus * 2.5,
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}