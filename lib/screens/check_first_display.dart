import 'package:flutter/material.dart';
import 'package:test_flutter/screens/FirstPage/presentation/horizon_firstpage.dart';
import 'package:test_flutter/screens/FirstPage/presentation/vertical_firstpage.dart';

class OrientationFirstPage extends StatefulWidget {
  const OrientationFirstPage({super.key});

  @override
  State<OrientationFirstPage> createState() => _OrientationFirstPageState();
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
