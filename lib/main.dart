import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'src/track.dart';
import 'src/play_bar.dart';

void main() {
  runApp(MyApp());
  print("Runnign!");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello World App'),
        ),
        body: Column(
            // child: GestureDetector(
            //   child: Text(
            //     'Hello, World!',
            //     style: TextStyle(fontSize: 24),
            //   ),
            //   // onTap: play,
            // ),
            children: <Widget>[
              ElevatedButton.icon(
                icon: Icon(Icons.play_arrow),
                label: Text("Play"),
                onPressed: play,
              ),
              PlayBar(),
            ]),
      ),
    );
  }
}
