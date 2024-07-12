import 'package:flutter/material.dart';
import 'package:test_flutter/screens/FirstPage/horizon_firstpage.dart';
import 'package:test_flutter/screens/FirstPage/vertical_firstpage.dart';

class OrientationExample extends StatefulWidget {
  const OrientationExample({super.key});

  @override
  _OrientationExampleState createState() => _OrientationExampleState();
}

class _OrientationExampleState extends State<OrientationExample> {
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
