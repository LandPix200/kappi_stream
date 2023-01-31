// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kappi_stream/pages/home.dart';

import 'search.dart';

class GlobalPage extends StatefulWidget {
  const GlobalPage({super.key});

  @override
  State<GlobalPage> createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  int ci = 0;
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    // AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[ci],

      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: GNav(
        gap: 10,
        activeColor: Theme.of(context).primaryColor,
        onTabChange: ((value) {
          setState(() {
            ci = value;
          });
        }),
        // ignore: prefer_const_literals_to_create_immutables
        tabs: [
          GButton(
            icon: Icons.line_style_outlined,
            text: "Au hazard",
          ),
          GButton(
            icon: Icons.search,
            text: "Recherches",
          ),
          // GButton(icon: Icons.person),
        ],
      ),
    );
  }
}
