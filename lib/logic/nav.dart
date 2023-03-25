import 'package:flutter/material.dart';

void push(Widget page, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => page

  ));
}


void pushR(Widget page, BuildContext context) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => page

  ));
}