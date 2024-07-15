import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/screens/SecoundPage/second_page.dart';
import 'package:test_flutter/screens/contact.dart';
import 'package:test_flutter/screens/contact2.dart';
import 'package:test_flutter/screens/menu_page.dart';

class FirstPageHorizontal extends StatefulWidget {
  const FirstPageHorizontal({super.key});

  @override
  State<FirstPageHorizontal> createState() => _FirstPageHorizontalState();
}

class _FirstPageHorizontalState extends State<FirstPageHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        double minHeight = 600.0;
        double minWidth = 300.0;

        double screenHeight = constraints.maxHeight < minHeight
            ? minHeight
            : constraints.maxHeight;
        double screenWidth =
            constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;

        double baseFontSize = screenWidth * 0.1;
        return Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   height: 60,
                    //   width: double.infinity,
                    //   margin: const EdgeInsets.symmetric(
                    //       horizontal: 30, vertical: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const ContactBottomsheet(),
                    //       InkWell(
                    //         onTap: () {
                    //           Navigator.pushReplacement(
                    //             context,
                    //             PageRouteBuilder(
                    //               pageBuilder:
                    //                   (context, animation1, animation2) =>
                    //                       const SecondPage(),
                    //               transitionDuration:
                    //                   const Duration(seconds: 0),
                    //               maintainState: false,
                    //             ),
                    //           );
                    //         },
                    //         child: SizedBox(
                    //           height: 20,
                    //           width: 20,
                    //           child: ClipOval(
                    //             child: Image.asset(
                    //               'assets/image/flag_usa.png',
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Text(
                      'Self-Service',
                      style: GoogleFonts.rasa(
                        fontSize: baseFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Experience.',
                      style: GoogleFonts.rasa(
                        fontSize: baseFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'From self-order and self-checkout',
                      style: GoogleFonts.roboto(
                        fontSize: screenWidth * 0.03,
                        color: const Color(0xFF7D7D7D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25,
                          width: 25,
                          child: ClipOval(
                            child: SvgPicture.asset(
                              'assets/svg/credit_card.svg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Accept only Credit Card',
                          style: GoogleFonts.roboto(
                            fontSize: screenWidth * 0.03,
                            color: const Color(0xFFEB5757),
                            fontWeight: FontWeight.bold,
                            // decoration: TextDecoration.underline,
                            // decorationColor: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
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
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFF496EE2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Tap to Order',
                            style: GoogleFonts.roboto(
                              fontSize: screenWidth * 0.03,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Image.asset(
                    'assets/gif/backgroud_app2.gif',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: SizedBox(
                height: screenHeight * 0.65,
                child: Image.asset(
                  'assets/image/vector_backgroud3.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
