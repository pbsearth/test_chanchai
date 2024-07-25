import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_flutter/screens/check_first_display.dart';
import 'package:test_flutter/screens/SecoundPage/widgets/cantact_vertical_second.dart';
import 'package:test_flutter/screens/SecoundPage/widgets/widget_secondpage.dart';

class SecondPageVertical extends StatefulWidget {
  const SecondPageVertical({super.key});

  @override
  State<SecondPageVertical> createState() => _SecondPageVerticalState();
}

class _SecondPageVerticalState extends State<SecondPageVertical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = MediaQuery.of(context).size.height;
          double screenWidth = MediaQuery.of(context).size.width;
          double plusscreen = screenHeight + screenWidth;
          double fontPlus = plusscreen * 0.1;
          double plusscreen2 =
              screenHeight + (screenWidth * 0.3 - screenHeight);
          double fontPlus2 = plusscreen2 * 2;

          return Stack(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: fontPlus * 0.2,
                        vertical: fontPlus * 0.2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.restaurant,
                                color: const Color(0xFF7D7D7D),
                                size: 1 + fontPlus2 * 0.05,
                              ),
                              SizedBox(
                                width: screenWidth * 0.01,
                              ),
                              Text(
                                'Soi Siam',
                                style: GoogleFonts.roboto(
                                  fontSize: 1 + fontPlus2 * 0.05,
                                  color: const Color(0xFF7D7D7D),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const OrientationFirstPage(),
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
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: screenHeight * 0.15,
                      left: 0,
                      child: SizedBox(
                        child: Image.asset(
                          'assets/image/vector_backgroud2.png',
                          scale: plusscreen * 0.0003,
                          fit: BoxFit.cover,
                          // color: Colors.amber,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: plusscreen * 0.1,
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
                              child: SvgPicture.asset(
                                  'assets/svg/credit_card.svg',
                                  fit: BoxFit.cover,
                                  height: plusscreen * 0.0115,
                                  width: plusscreen * 0.0115),
                            ),
                            SizedBox(
                              width: plusscreen * 0.005,
                            ),
                            Flexible(
                              child: Text(
                                'Accept Credit Card Only',
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
                          height: plusscreen * 0.03,
                        ),
                        WidgetSecondPage(
                          height: screenHeight * 0.27,
                          width: screenWidth * 0.42,
                          bottom1: screenHeight * 0.045,
                          bottom2: screenHeight * 0.045,
                          font: 0.055,
                          heighttext: screenHeight * 0.065,
                        ),
                        SizedBox(
                          height: fontPlus * 0.7,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [ContactSecondVertical()],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
