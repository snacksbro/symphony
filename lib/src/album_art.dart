import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AlbumArt extends StatefulWidget {
  final String songPath;
  const AlbumArt({super.key, required this.songPath});
  @override
  State<AlbumArt> createState() => _AlbumArtState();
}

class _AlbumArtState extends State<AlbumArt> {
  String getCoverLocation() {
    List<String> sourceSplit = widget.songPath.split("/");
    sourceSplit[sourceSplit.length - 1] = "cover.png";
    return sourceSplit.join("/");
  }

  Widget build(BuildContext context) {
    // return Text(widget.songPath + " " + getCoverLocation());
    // return Container(
    //   width: 200,
    //   height: 200,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     image: DecorationImage(
    //       image: FileImage(
    //         // Load image from file path
    //         AssetImage(getCoverLocation()).assetName,
    //       ),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    // );

    return Image(
        image: AssetImage(getCoverLocation()), width: 200, height: 200);
  }
}
