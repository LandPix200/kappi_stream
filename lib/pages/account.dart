// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: GFAppBar(
        title: Text("Kappi stream"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GFStickyHeader(
                stickyContent: Container(
                  width: double.maxFinite,
                  height: 200,
                  color: Colors.deepPurple,
                ),
                content: Column(
                  children: Colors.primaries
                      .map(
                        (e) => Container(
                          width: double.maxFinite,
                          height: 20,
                          color: e,
                        ),
                      )
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
}
