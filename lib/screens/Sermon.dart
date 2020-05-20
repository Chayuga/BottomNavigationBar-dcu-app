import 'package:flutter/material.dart';


class Sermon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sermon Page',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sermon Page'),
        ),
        body: Center(
          child: Text('Sermon'),
        ),
      ),
    );
  }
}