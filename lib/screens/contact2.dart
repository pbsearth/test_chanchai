import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Contact2 extends StatelessWidget {
  const Contact2({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          context: context,
          builder: (BuildContext context) {
            return Container(
              color: const Color(0xFF212121),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      screenHeight * 0.04,
                      screenHeight * 0.05,
                      screenHeight * 0.04,
                      screenHeight * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextStyle(
                                label: "ติดต่อเรา",
                                fontSize: 18.0 * textScaleFactor,
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              CustomTextStyle(
                                label:
                                    "28 ซอยรัตนาธิเบศร์ 28 แขวงบางกระสอ เขตเมืองนนทบุรี จังหวัดนนทบุรี 11000",
                                fontSize: 12.0 * textScaleFactor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/image/phone_icon.png',
                                          height: screenHeight * 0.015,
                                          width: screenHeight * 0.015,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      SvgPicture.asset(
                                        'assets/svg/instagram_icon.svg',
                                        height: screenHeight * 0.03,
                                        width: screenHeight * 0.03,
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/image/youtube_icon.png',
                                          height: screenHeight * 0.018,
                                          width: screenHeight * 0.018,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/image/mail_icon.png',
                                          height: screenHeight * 0.018,
                                          width: screenHeight * 0.018,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                   Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextStyle(
                                        label: "090-890-xxxx",
                                        fontSize: 10.0 * textScaleFactor,
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      CustomTextStyle(
                                        label: "SoiSiam",
                                        fontSize: 10.0 * textScaleFactor,
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      CustomTextStyle(
                                        label: "SoiSiam Channel",
                                        fontSize: 10.0 * textScaleFactor,
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      CustomTextStyle(
                                        label: "SoiSiam@gmail.co.th",
                                        fontSize: 10.0 * textScaleFactor,
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Row(
        children: [
          const Icon(
            Icons.restaurant,
            color: Colors.grey,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Soi Siam',
            style: GoogleFonts.roboto(fontSize: 18.0 * textScaleFactor, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class CustomTextStyle extends StatelessWidget {
  final String label;
  final double fontSize;

  const CustomTextStyle({Key? key, required this.label, this.fontSize = 12.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.roboto(color: Colors.white, fontSize: fontSize),
    );
  }
}
