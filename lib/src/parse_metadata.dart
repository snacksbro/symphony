import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:convert';

int headerCharCount = 500;

class MetaObject {
  String songPath;
  String songArtist = "";
  String songAlbum = "";
  String songTitle = "";

  MetaObject(this.songPath) {}

  Future<void> initialize() async {
    List<String> songMetadata = await getHeader();
    songArtist = trimToHeaderChar(songMetadata[0]);
    songAlbum = trimToHeaderChar(songMetadata[1]);
    songTitle = trimToHeaderChar(songMetadata[2]);
  }

  String trimToHeaderChar(String str) {
    for (int i = 0; i < str.length; i++) {
      if (str.codeUnitAt(i) >= 32 && str.codeUnitAt(i + 1) >= 32) {
        return str.substring(i);
      }
    }
    return str;
  }

  // Future<Uint8List> loadSong() async {

  // Convert the data to UTF-8 encoding
  // String decodedData = utf8.decode(songData);
  // Uint8List utf8EncodedData = utf8.encode(decodedData);
  // getHeader(songData);
  // return data.buffer.asUint8List();
  // }

  Future<List<String>> getHeader() async {
    // Loading in the song
    ByteData data = await rootBundle.load(songPath);
    Uint8List songData = data.buffer.asUint8List();

    // Ripping out the header
    List<int> header = songData.sublist(0, headerCharCount);

    // Decoding it
    String decoded_header = latin1.decode(header);

    // Second approach
    Map metaInfo = {
      'album': {
        'start': decoded_header.lastIndexOf("TALB") + 4,
        'end': decoded_header.lastIndexOf("TALB"),
        'value': ""
      },
      'artist': {
        'start': decoded_header.lastIndexOf("TPE1") + 4,
        'end': decoded_header.lastIndexOf("TPE1"),
        'value': ""
      },
      'title': {
        'start': decoded_header.lastIndexOf("TIT2") + 4,
        'end': decoded_header.lastIndexOf("TIT2"),
        'value': ""
      },
      'settings': {
        // DONT TOUCH THIS INDEX
        'start': decoded_header.lastIndexOf("TSSE"),
        'end': decoded_header.lastIndexOf("TSSE"),
        'value': ""
      }
    };

    // Grab all the start positions and sort ascending
    List<int> startPositions = [];
    metaInfo.forEach((key, value) {
      startPositions.add(value['start']);
      startPositions.sort();
    });

    // Figuring out where each end is
    metaInfo.forEach((key, value) {
      for (int i = 0; i < startPositions.length; i++) {
        if (startPositions[i] > value['start']) {
          value["end"] = startPositions[i] - 4;
          print("${key} set to ${value['end']}");
          break;
        } else {
          print("FAILURE ${startPositions[i]} !> ${value['start']}");
        }
      }
    });

    // Write to map and print
    metaInfo.forEach((key, value) {
      value['value'] = decoded_header.substring(value['start'], value['end']);
      print("${key} ${value['start']}:${value['end']}");
    });

    // Map artistStart = {'artist': decoded_header.lastIndexOf("TPE1")};
    // Map titleStart = {'title': decoded_header.lastIndexOf("TIT2")};
    // Map settingsStart = {'settings': decoded_header.lastIndexOf("TSSE")};
    // Map albumEnd = {'album': 0};
    // Map artistEnd = {'artist': 0};
    // Map titleEnd = {'title': 0};
    // Map settingsEnd = {'settings': 0};
    // List<Map> tagIndexes = [albumStart, artistStart, titleStart, settingsStart];

    // tagIndexes.sort((a, b) => a.values.first.compareTo(b.values.first));
    // for (int i = 0; i < tagIndexes.length; i++) {
    //   tagIndexes[i].forEach((key, value) {});
    // }
    // tagIndexes.sort((a, b) => (b['age']).compareTo(a['age']));

    // Parse out the values
    // List<String> album_arr = decoded_header.split("TALB");
    // List<String> artist_arr = album_arr[1].split("TPE1");
    // String song_album = artist_arr[0];
    // List<String> title_arr = artist_arr[1].split("TIT2");
    // String song_artist = title_arr[0];
    // List<String> newline_arr = title_arr[1].split("TSSE");
    // String song_title = newline_arr[0];

    // Printing for good measure
    // print("TITLE IS " + song_title);
    // print("ALBUM IS " + song_album);
    // print("ARTIST IS " + song_artist);
    // Preceeds ^C for chars? May be how to fix the title
    String song_artist = metaInfo['artist']['value'];
    String song_album = metaInfo['album']['value'];
    String song_title = metaInfo['title']['value'];
    return [song_artist, song_album, song_title];
  }

  String getFormat() {
    // TODO: Make this handle multiple periods in filename
    return songPath.split(".")[1];
  }
}
