import 'package:flutter/material.dart';
import 'src/play_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello World App'),
        ),
        body: Column(children: <Widget>[
          PlayBar(),
        ]),
      ),
    );
  }
}
