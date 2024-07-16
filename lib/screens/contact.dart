import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactBottomsheet extends StatefulWidget {
  const ContactBottomsheet({super.key});

  @override
  State<ContactBottomsheet> createState() => _ContactBottomsheetState();
}

class _ContactBottomsheetState extends State<ContactBottomsheet> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // double plusscreen = screenHeight + screenWidth;
    double plusscreen2 = screenHeight + (screenWidth * 0.3 - screenHeight);
    double plusscreen = screenHeight + screenWidth;

    // double fontPlus = plusscreen * 0.1;
    double fontPlus2 = plusscreen2 * 2;
    double fontPlus3 = plusscreen2 * 5;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            // maxHeight: MediaQuery.of(context).size.height * 0.183,
          ),
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: plusscreen * 0.12,
              color: const Color(0xFF212121),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(fontPlus3 * 0.02 * 1,
                            fontPlus3 * 0.02 * 2, fontPlus3 * 0.02 * 1, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomTextStyle(
                                    label: "Contact Us",
                                  ),
                                  SizedBox(
                                    height: 1 + fontPlus2 * 0.015,
                                  ),
                                  const CustomTextStyle(
                                    label:
                                        "Rattanathibech 28 Alley, Tambon Bang Kraso, Mueang Nonthaburi District, Nonthaburi 11000",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/phone_icon.svg',
                                            height: 10 + fontPlus2 * 0.0005,
                                            width: 10 + fontPlus2 * 0.0005,
                                          ),
                                          SizedBox(
                                            height: 3 + fontPlus2 * 0.025,
                                          ),
                                          SvgPicture.asset(
                                            'assets/svg/instagram_icon.svg',
                                            height: 10 + fontPlus2 * 0.02,
                                            width: 10 + fontPlus2 * 0.02,
                                          ),
                                          SizedBox(
                                            height: 3 + fontPlus2 * 0.025,
                                          ),
                                          SvgPicture.asset(
                                            'assets/svg/youtube_icon.svg',
                                            height: 10 + fontPlus2 * 0.0005,
                                            width: 10 + fontPlus2 * 0.0005,
                                          ),
                                          SizedBox(
                                            height: 3 + fontPlus2 * 0.025,
                                          ),
                                          SvgPicture.asset(
                                            'assets/svg/mail_icon.svg',
                                            height: 10 + fontPlus2 * 0.0005,
                                            width: 10 + fontPlus2 * 0.0005,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "090-890-xxxx",
                                              style: TextStyle(
                                                  fontSize:
                                                      1 + fontPlus2 * 0.02,
                                                  color: Colors.white),
                                              softWrap: true,
                                              maxLines: null,
                                            ),
                                            SizedBox(
                                              height: 3 + fontPlus2 * 0.025,
                                            ),
                                            Text(
                                              "SoiSiam",
                                              style: TextStyle(
                                                  fontSize:
                                                      1 + fontPlus2 * 0.02,
                                                  color: Colors.white),
                                              softWrap: true,
                                              maxLines: null,
                                            ),
                                            SizedBox(
                                              height: 3 + fontPlus2 * 0.025,
                                            ),
                                            Text(
                                              "SoiSiam Chanal",
                                              style: TextStyle(
                                                  fontSize:
                                                      1 + fontPlus2 * 0.02,
                                                  color: Colors.white),
                                              softWrap: true,
                                              maxLines: null,
                                            ),
                                            SizedBox(
                                              height: 3 + fontPlus2 * 0.025,
                                            ),
                                            Text(
                                              "SoiSiam@gmail.co.th",
                                              style: TextStyle(
                                                  fontSize:
                                                      1 + fontPlus2 * 0.02,
                                                  color: Colors.white),
                                              softWrap: true,
                                              maxLines: null,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              '© Copyright 2022 l Powered by',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 1 + fontPlus2 * 0.03),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            'assets/image/smile_icon.png',
                            height: 10 + fontPlus2 * 0.05,
                            width: 10 + fontPlus2 * 0.05,
                          ),
                        ],
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
    );
  }
}

class CustomTextStyle extends StatelessWidget {
  final String label;

  const CustomTextStyle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double plusscreen2 = screenHeight + (screenWidth * 0.3 - screenHeight);
    double fontPlus2 = plusscreen2 * 2;
    return Text(
      label,
      style: GoogleFonts.roboto(
          color: Colors.white, fontSize: 1 + fontPlus2 * 0.02),
    );
  }
}
