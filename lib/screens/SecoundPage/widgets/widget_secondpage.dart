import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter/screens/MenuPage/presentation/menu_page.dart';

class WidgetSecondPage extends StatefulWidget {
  final double height;
  final double width;
  final double heighttext;
  final double bottom1;
  final double bottom2;
  final double font;

  const WidgetSecondPage({
    super.key,
    required this.height,
    required this.width,
    required this.bottom1,
    required this.bottom2,
    required this.font,
    required this.heighttext,
  });

  @override
  State<WidgetSecondPage> createState() => _WidgetSecondPageState();
}

class _WidgetSecondPageState extends State<WidgetSecondPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen = screenHeight + screenWidth;
    double plusscreen2 = screenHeight + (screenWidth * 0.3 - screenHeight);
    double fontPlus2 = plusscreen2 * 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
              child: Stack(
                children: [
                  Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(1, 5), // Shadow position
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: widget.bottom1,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(5)),
                      child: Image.asset(
                        'assets/gif/buttom1.gif',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: widget.heighttext,
                      width: widget.width,
                      decoration: const BoxDecoration(
                          color: Color(0xFF496EE2),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(5))),
                      child: Center(
                        child: Text(
                          'To Stay',
                          style: GoogleFonts.roboto(
                            fontSize: 1 + fontPlus2 * widget.font,
                            color: Colors.white,
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
        SizedBox(
          width: plusscreen * 0.01,
        ),
        Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
              child: Stack(
                children: [
                  Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(1, 5),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: widget.bottom2,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(5)),
                      child: Image.asset(
                        'assets/gif/buttom2.gif',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: widget.heighttext,
                      width: widget.width,
                      decoration: const BoxDecoration(
                          color: Color(0xFFFAA21C),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(5))),
                      child: Center(
                        child: Text(
                          'Togo Walk-in',
                          style: GoogleFonts.roboto(
                            fontSize: 1 + fontPlus2 * widget.font,
                            color: Colors.white,
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
      ],
    );
  }
}
