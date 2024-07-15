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
    double plusscreen = screenHeight + screenWidth;
    double fontPlus = plusscreen * 0.1;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height * 0.2,
          ),
          context: context,
          builder: (BuildContext context) {
            return Container(
              color: const Color(0xFF212121),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextStyle(
                                label: "Contact Us",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextStyle(
                                label:
                                    "Rattanathibech 28 Alley, Tambon Bang Kraso, Mueang Nonthaburi District, Nonthaburi 11000",
                              ),
                            ],
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
                                            height: 12,
                                            width: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        SvgPicture.asset(
                                          'assets/svg/instagram_icon.svg',
                                          height: 22,
                                          width: 22,
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        ClipOval(
                                          child: Image.asset(
                                            'assets/image/youtube_icon.png',
                                            height: 14,
                                            width: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        ClipOval(
                                          child: Image.asset(
                                            'assets/image/mail_icon.png',
                                            height: 14,
                                            width: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextStyle(
                                          label: "090-890-xxxx",
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextStyle(
                                          label: "SoiSiam",
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextStyle(
                                          label: "SoiSiam Chanal",
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextStyle(
                                          label: "SoiSiam@gmail.co.th",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '© Copyright 2022 l Powered by',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/image/smile_icon.png',
                        height: 35,
                        width: 35,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Row(
        children: [
          Icon(
            Icons.restaurant,
            color: Color(0xFF7D7D7D),
            size: 3 + fontPlus * 0.15,
          ),
           SizedBox(
            width: screenWidth * 0.02,
          ),
          Text(
            'Soi Siam',
            style: GoogleFonts.roboto(
                fontSize: 3 + fontPlus * 0.15,
                color: Color(0xFF7D7D7D),
                fontWeight: FontWeight.bold),
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
    return Text(
      label,
      style: GoogleFonts.roboto(color: Colors.white, fontSize: 9),
    );
  }
}
