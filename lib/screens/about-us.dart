import 'package:flutter/material.dart';


class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anout us page',
      home: Scaffold(
        appBar: AppBar(
          title: Text('About us page'),
        ),
        body: Center(
          child: Text('About us page'),
        ),
      ),
    );
  }
}