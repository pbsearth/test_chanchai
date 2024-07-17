import 'package:flutter/material.dart';
import 'package:test_flutter/screens/SecoundPage/presentation/horizon_secondpage.dart';
import 'package:test_flutter/screens/SecoundPage/presentation/vertical_secondpage.dart';

class OrientationSecoundPage extends StatefulWidget {
  const OrientationSecoundPage({super.key});

  @override
  State<OrientationSecoundPage> createState() => _OrientationSecoundPageState();
}

class _OrientationSecoundPageState extends State<OrientationSecoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? const SecondPageVertical()
              : const SecondPageHorizontal();
        },
      ),
    );
  }
}
