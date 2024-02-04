import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'src/track.dart';

void main() {
  runApp(MyApp());
  print("Runnign!");
  play();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello World App'),
        ),
        body: Center(
          child: GestureDetector(
            child: Text(
              'Hello, World!',
              style: TextStyle(fontSize: 24),
            ),
            onTap: play,
          ),
        ),
      ),
    );
  }
}
