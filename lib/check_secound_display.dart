import 'package:flutter/material.dart';
import 'package:test_flutter/screens/FirstPage/horizon_firstpage.dart';
import 'package:test_flutter/screens/FirstPage/vertical_firstpage.dart';

class OrientationSecoundPage extends StatefulWidget {
  const OrientationSecoundPage({super.key});

  @override
  _OrientationSecoundPageState createState() => _OrientationSecoundPageState();
}

class _OrientationSecoundPageState extends State<OrientationSecoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? const FirstPageVertical()
              : const FirstPageHorizontal();
        },
      ),
    );
  }
}
