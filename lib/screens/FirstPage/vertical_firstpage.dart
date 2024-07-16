import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/screens/check_second_display.dart';
import 'package:test_flutter/screens/FirstPage/contact_vertical_first.dart';
import 'package:test_flutter/screens/menu_page.dart';

class FirstPageVertical extends StatefulWidget {
  const FirstPageVertical({super.key});

  @override
  State<FirstPageVertical> createState() => _FristPageVerticalState();
}

class _FristPageVerticalState extends State<FirstPageVertical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenHeight = MediaQuery.of(context).size.height;
            double screenWidth = MediaQuery.of(context).size.width;
            double plusscreen = screenHeight + screenWidth;
            double necscreen = screenHeight - screenWidth;
            double fontPlus = plusscreen * 0.1;
            double plusscreen2 =
                screenHeight + (screenWidth * 0.3 - screenHeight);
            double fontPlus2 = plusscreen2 * 2;
            // double necscreenabs = necscreen.abs();
            // print('screenHeight : ${screenHeight}');
            // print('screenWidth : ${screenWidth}');
            // print('plusscreen : ${plusscreen}');
            // print('necscreen : ${necscreen}');
            // print('necscreenabs : ${necscreenabs}');
            // print('new : ${screenHeight - necscreenabs}');

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
                          SizedBox(
                            width: 10,
                            height: (screenHeight - necscreen) * 0.57,
                            // color: Colors.amber,
                          ),
                          SizedBox(
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
                                      size: 1 + fontPlus2 * 0.06,
                                    ),
                                    Text(
                                      'Soi Siam',
                                      style: GoogleFonts.rasa(
                                        fontSize: 1 + fontPlus2 * 0.06,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Restaurant',
                                      style: GoogleFonts.rasa(
                                        fontSize: 1 + fontPlus2 * 0.06,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: plusscreen * 0.01,
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
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: fontPlus * 0.2,
                        vertical: fontPlus * 0.2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ContactFirstVertical(),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const OrientationSecoundPage(),
                                  transitionDuration:
                                      const Duration(seconds: 0),
                                  maintainState: false,
                                ),
                              );
                            },
                            child: Flexible(
                              child: SizedBox(
                                height: 2 + fontPlus * 0.1,
                                width: 2 + fontPlus * 0.1,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/image/usa_flag_new.png',
                                    fit: BoxFit.cover,
                                  ),
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
                        fontSize: plusscreen * 0.037,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Experience.',
                      style: GoogleFonts.rasa(
                        fontSize: plusscreen * 0.037,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: plusscreen * 0.0035,
                    ),
                    Text(
                      'From self-order and self-checkout',
                      style: GoogleFonts.roboto(
                        fontSize: plusscreen * 0.0115,
                        color: const Color(0xFF7D7D7D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: plusscreen * 0.0035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: SvgPicture.asset('assets/svg/credit_card.svg',
                              fit: BoxFit.cover,
                              height: plusscreen * 0.0115,
                              width: plusscreen * 0.0115),
                        ),
                        SizedBox(
                          width: plusscreen * 0.005,
                        ),
                        Flexible(
                          child: Text(
                            'Accept only Credit Card',
                            style: GoogleFonts.roboto(
                                fontSize: plusscreen * 0.0115,
                                color: const Color(0xFFEB5757),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: const Color(0xFFEB5757)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: plusscreen * 0.02,
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
                        height: plusscreen * 0.045,
                        width: plusscreen * 0.15,
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
                      height: fontPlus * 3.25,
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
