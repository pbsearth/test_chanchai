import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_flutter/screens/check_first_display.dart';
import 'package:test_flutter/screens/SecoundPage/widgets/contact_horizon_second.dart';
import 'package:test_flutter/screens/SecoundPage/widgets/widget_secondpage.dart';

class SecondPageHorizontal extends StatefulWidget {
  const SecondPageHorizontal({super.key});

  @override
  State<SecondPageHorizontal> createState() => _SecondPageHorizontalState();
}

class _SecondPageHorizontalState extends State<SecondPageHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;
        double plusscreen = screenHeight + screenWidth;
        double fontPlus = plusscreen * 0.1;
        double plusscreen2 = screenHeight + (screenWidth * 0.3 - screenHeight);
        double fontPlus2 = plusscreen2 * 2;
        return Stack(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/image/vector_backgroud3.png',
                  fit: BoxFit.fill,
                  scale: 1.9,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Positioned(
                        top: 10,
                        left: 0,
                        bottom: 0,
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: fontPlus * 0.1,
                                      horizontal: fontPlus * 0.15),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.restaurant,
                                        color: const Color(0xFF7D7D7D),
                                        size: 0.5 + fontPlus2 * 0.03,
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.01,
                                      ),
                                      Text(
                                        'Soi Siam',
                                        style: GoogleFonts.roboto(
                                          fontSize: 0.5 + fontPlus2 * 0.03,
                                          color: const Color(0xFF7D7D7D),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: plusscreen * 0.025,
                                ),
                                Text(
                                  'Self-Service',
                                  style: GoogleFonts.rasa(
                                    fontSize: plusscreen * 0.035,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Experience.',
                                  style: GoogleFonts.rasa(
                                    fontSize: plusscreen * 0.035,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: plusscreen * 0.005,
                                ),
                                Text(
                                  'From self-order and self-checkout',
                                  style: GoogleFonts.roboto(
                                    fontSize: plusscreen * 0.01,
                                    color: const Color(0xFF7D7D7D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: plusscreen * 0.002,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: SvgPicture.asset(
                                          'assets/svg/credit_card.svg',
                                          fit: BoxFit.cover,
                                          height: plusscreen * 0.01,
                                          width: plusscreen * 0.01),
                                    ),
                                    SizedBox(
                                      width: plusscreen * 0.005,
                                    ),
                                    Flexible(
                                      child: Text(
                                        'Accept Credit Card only',
                                        style: GoogleFonts.roboto(
                                            fontSize: plusscreen * 0.01,
                                            color: const Color(0xFFEB5757),
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                const Color(0xFFEB5757)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: plusscreen * 0.045,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Positioned(
                        right: 0,
                        bottom: 0,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              const OrientationFirstPage(),
                                          transitionDuration:
                                              const Duration(seconds: 0),
                                          maintainState: false,
                                        ),
                                      );
                                    },
                                    child: Flexible(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: fontPlus * 0.1,
                                            horizontal: fontPlus * 0.15),
                                        height: 2 + fontPlus * 0.13,
                                        width: 2 + fontPlus * 0.13,
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/image/usa_flag_new.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                WidgetSecondPage(
                                  height: screenHeight * 0.4,
                                  width: screenWidth * 0.25,
                                  bottom1: screenHeight * 0.025,
                                  bottom2: screenHeight * 0.04,
                                  font: 0.025,
                                  heighttext: screenHeight * 0.08,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ContactSecondHorizon()))
          ],
        );
      }),
    );
  }
}
