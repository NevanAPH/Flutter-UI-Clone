import 'package:flutter/material.dart';

// Import utilities
import '/utils/colors.dart';

class CountriesSelectPage extends StatefulWidget {
  const CountriesSelectPage({super.key});

  @override
  State<CountriesSelectPage> createState() => _CountriesSelectPageState();
}

class _CountriesSelectPageState extends State<CountriesSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: ThemeColor.background,
          ),
          width: double.infinity,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      )
                    ],
                  ),
                ),
              ]))),
    );
  }
}
