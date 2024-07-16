import 'package:flutter/material.dart';
import 'package:test_flutter/screens/FirstPage/horizon_firstpage.dart';
import 'package:test_flutter/screens/FirstPage/vertical_firstpage.dart';

class OrientationFirstPage extends StatefulWidget {
  const OrientationFirstPage({super.key});

  @override
  _OrientationFirstPageState createState() => _OrientationFirstPageState();
}

class _OrientationFirstPageState extends State<OrientationFirstPage> {
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
