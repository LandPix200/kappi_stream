import 'package:flutter/material.dart';

void push(Widget page, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => page

  ));
}
