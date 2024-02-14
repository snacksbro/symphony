import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:convert';

int headerCharCount = 500;

class MetaObject {
  String songPath;

  MetaObject(this.songPath) {}

  String getTitle() {
    return "test title!";
  }

  Future<Uint8List> loadSong() async {
    ByteData data = await rootBundle.load(songPath);
    Uint8List songData = data.buffer.asUint8List();

    // Convert the data to UTF-8 encoding
    // String decodedData = utf8.decode(songData);
    // Uint8List utf8EncodedData = utf8.encode(decodedData);
    getHeader(songData);
    return data.buffer.asUint8List();
  }

  void getHeader(Uint8List oggData) {
    List<int> header = oggData.sublist(0, headerCharCount);
    String decoded_header = latin1.decode(header);
    print(decoded_header);
    List<String> album_arr = decoded_header.split("TALB");
    List<String> artist_arr = album_arr[1].split("TPE1");
    String song_album = artist_arr[0];
    List<String> title_arr = artist_arr[1].split("TIT2");
    String song_artist = title_arr[0];
    List<String> newline_arr = title_arr[1].split("TSSE");
    String song_title = newline_arr[0];
    print("TITLE IS " + song_title);
    print("ALBUM IS " + song_album);
    print("ARTIST IS " + song_artist);
    // Preceeds ^C for chars? May be how to fix the title
  }

  String getFormat() {
    // TODO: Make this handle multiple periods in filename
    return songPath.split(".")[1];
  }
}
