import 'package:flutter/material.dart';

import 'bottom_navy_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyBottomNavigationBar(),
    );
  }
}
