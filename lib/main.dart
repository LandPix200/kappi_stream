// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kappi_stream/pages/global.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kappi Stream',
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: GoogleFonts.alef(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.black87,
          titleTextStyle: GoogleFonts.alef(
            fontSize: 18,
            color: Colors.deepOrangeAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        dividerTheme: DividerThemeData(
          color: Colors.red,
          space: 10,
          thickness: 3,
        ),
      ),
      home: const GlobalPage(),
    );
  }
}
// AIzaSyAbwWKpNNDTCVyGwzuvfx4R8z4-SZ_ggVc