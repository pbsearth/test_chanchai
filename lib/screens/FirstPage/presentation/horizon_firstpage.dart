import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/screens/FirstPage/Widgets/contact_horizon_first.dart';
import 'package:test_flutter/screens/MenuPage/presentation/menu_page.dart';
import 'package:test_flutter/screens/check_second_display.dart';

class FirstPageHorizontal extends StatefulWidget {
  const FirstPageHorizontal({super.key});

  @override
  State<FirstPageHorizontal> createState() => _FirstPageHorizontalState();
}

class _FirstPageHorizontalState extends State<FirstPageHorizontal> {
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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/gif/backgroud_app2.gif',
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: plusscreen * 0.1,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.restaurant,
                                color: Colors.white,
                                size: 1 + fontPlus2 * 0.035,
                              ),
                              SizedBox(
                                width: plusscreen * 0.005,
                              ),
                              Text(
                                'Soi Siam',
                                style: GoogleFonts.rasa(
                                  fontSize: 1 + fontPlus2 * 0.035,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const OrientationSecoundPage(),
                                transitionDuration: const Duration(seconds: 0),
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
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(
                      'assets/image/vector_backgroud3.png',
                      fit: BoxFit.fill,
                      // scale: 2,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
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
                                      'Accept only Credit Card',
                                      style: GoogleFonts.roboto(
                                          fontSize: plusscreen * 0.01,
                                          color: const Color(0xFFEB5757),
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              const Color(0xFFEB5757)),
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
                            ],
                          ),
                        ),
                      ),
                      Expanded(flex: 5, child: Container())
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: fontPlus * 0.1, horizontal: fontPlus * 0.15),
              child: const ContactFirstHorizon(),
            ),
          ],
        );
      }),
    );
  }
}
