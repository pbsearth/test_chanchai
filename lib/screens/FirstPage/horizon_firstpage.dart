import 'package:flutter/material.dart';
import 'package:test_flutter/screens/contact.dart';
import 'package:test_flutter/screens/contact2.dart';

class FirstPageHorizontal extends StatefulWidget {
  const FirstPageHorizontal({super.key});

  @override
  State<FirstPageHorizontal> createState() => _FirstPageHorizontalState();
}

class _FirstPageHorizontalState extends State<FirstPageHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(
              'assets/gif/backgroud_app2.gif',
              fit: BoxFit.fill,
            ),
          ),
              const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Align(alignment: Alignment.topLeft, child: Contact2()),
              )
            ],
          ),
        ],
      ),
    );
  }
}
