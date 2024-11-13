// To parse this JSON data, do
//
//     final customKroakeModel = customKroakeModelFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

// To parse this JSON data, do
//
//     final customKroakeModel = customKroakeModelFromJson(jsonString);
CustomKroakeModel customKroakeModelFromJson(String str) =>
    CustomKroakeModel.fromJson(json.decode(str));

String customKroakeModelToJson(CustomKroakeModel data) =>
    json.encode(data.toJson());

class CustomKroakeModel {
  Karaoke karaoke;

  CustomKroakeModel({
    required this.karaoke,
  });

  factory CustomKroakeModel.fromJson(Map<String, dynamic> json) =>
      CustomKroakeModel(
        karaoke: Karaoke.fromJson(json["KARAOKE"]),
      );

  Map<String, dynamic> toJson() => {
        "KARAOKE": karaoke.toJson(),
      };

  String generateLyricFile() {
    StringBuffer buffer = StringBuffer();
    log("Karaoke Title ${karaoke.ltaginfo.cTitle1}");

    // Add metadata
    buffer.writeln('[ti:${karaoke.ltaginfo.cTitle1}]');
    buffer.writeln('[ar:${karaoke.ltaginfo.cAuthor}]');

    // Assuming records are sorted by time
    if (karaoke.stag.record.isNotEmpty) {
      int firstTimestamp = int.parse(karaoke.stag.record.first.lTimeSyncStart);
      int offset = firstTimestamp - 22000; // Adjust this calculation as needed
      buffer.writeln('[offset:$offset]');
    } else {
      buffer.writeln('[offset:0]');
    }

    Set<int> processedLines = {};

    for (Record record in karaoke.stag.record) {
      int lineIndex = int.parse(record.nLineDisplay) - 1;

      if (processedLines.contains(lineIndex)) {
        continue;
      }

      if (lineIndex >= 0 && lineIndex < karaoke.ltag.pszLineLyrics.length) {
        buffer.writeln(
            '${formatTime(int.parse(record.lTimeSyncStart))}${karaoke.ltag.pszLineLyrics[lineIndex]}');
        processedLines.add(lineIndex);
      } else {
        print('Invalid line index or line lyrics for index: $lineIndex');
      }
    }

    return buffer.toString();
  }

  ///Yeh Method Custom Lyrics Output file banakr degaaa
  ///
  ///WOrking one
  // String generateLyricFile() {
  //   StringBuffer buffer = StringBuffer();
  //   log("Karaoke Title ${karaoke.ltaginfo.cTitle1}");

  //   // Add metadata
  //   buffer.writeln('[ti:${karaoke.ltaginfo.cTitle1}]');
  //   buffer.writeln('[ar:${karaoke.ltaginfo.cAuthor}]');
  //   buffer.writeln('[offset:0]');

  //   // Create a set to keep track of processed lines
  //   Set<int> processedLines = {};

  //   // Iterate over each record
  //   for (Record record in karaoke.stag.record) {
  //     int lineIndex =
  //         int.parse(record.nLineDisplay) - 1; // Offset-based line index

  //     // Check if the line has already been processed
  //     if (processedLines.contains(lineIndex)) {
  //       continue; // Skip if already processed
  //     }

  //     if (lineIndex >= 0 && lineIndex < karaoke.ltag.pszLineLyrics.length) {
  //       buffer.writeln(
  //           '${formatTime(int.parse(record.lTimeSyncStart))}${karaoke.ltag.pszLineLyrics[lineIndex]}');
  //       processedLines.add(lineIndex); // Mark this line as processed
  //     } else {
  //       print('Invalid line index or line lyrics for index: $lineIndex');
  //     }
  //   }

  //   return buffer.toString();
  // }

  // String generateLyricFile() {
  //   StringBuffer buffer = StringBuffer();
  //   log("Karaoke Title ${karaoke.ltaginfo.cTitle1}");
  //   // Add metadata
  //   buffer.writeln('[ti:${karaoke.ltaginfo.cTitle1}]');
  //   buffer.writeln('[ar:${karaoke.ltaginfo.cAuthor}]');
  //   // Add other metadata as needed

  //   // Add initial offset
  //   buffer.writeln('[offset:0]');

  //   // Iterate over each record and append line lyrics to the buffer
  //   for (Record record in karaoke.stag.record) {
  //     int lineIndex =
  //         int.parse(record.nLineDisplay) - 1; // Offset-based line index

  //     if (lineIndex >= 0 && lineIndex < karaoke.ltag.pszLineLyrics.length) {
  //       buffer.writeln(
  //           '${formatTime(int.parse(record.lTimeSyncStart))}${karaoke.ltag.pszLineLyrics[lineIndex]}');
  //     } else {
  //       print('Invalid line index or line lyrics for index: $lineIndex');
  //     }
  //   }

  //   return buffer.toString();
  // }

  String formatTime(int milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds);
    return '[${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}.${((duration.inMilliseconds % 1000) / 10).floor().toString().padLeft(2, '0')}]';
  }
}

class Karaoke {
  Ctag ctag;
  Ltaginfo ltaginfo;
  Ltag ltag;
  Stag stag;

  Karaoke({
    required this.ctag,
    required this.ltaginfo,
    required this.ltag,
    required this.stag,
  });

  factory Karaoke.fromJson(Map<String, dynamic> json) => Karaoke(
        ctag: Ctag.fromJson(json["CTAG"]),
        ltaginfo: Ltaginfo.fromJson(json["LTAGINFO"]),
        ltag: Ltag.fromJson(json["LTAG"]),
        stag: Stag.fromJson(json["STAG"]),
      );

  Map<String, dynamic> toJson() => {
        "CTAG": ctag.toJson(),
        "LTAGINFO": ltaginfo.toJson(),
        "LTAG": ltag.toJson(),
        "STAG": stag.toJson(),
      };
}

class Ctag {
  String byteVersion;
  String nTotalLyrics;
  String nTotalPicture;
  String lPosLyrics;
  String lPosSync;
  String lPosPicture;
  String nStartPos;
  String nEndPos;
  String lPosStream;
  String lLenStream;

  Ctag({
    required this.byteVersion,
    required this.nTotalLyrics,
    required this.nTotalPicture,
    required this.lPosLyrics,
    required this.lPosSync,
    required this.lPosPicture,
    required this.nStartPos,
    required this.nEndPos,
    required this.lPosStream,
    required this.lLenStream,
  });

  factory Ctag.fromJson(Map<String, dynamic> json) => Ctag(
        byteVersion: json["byteVersion"],
        nTotalLyrics: json["nTotalLyrics"],
        nTotalPicture: json["nTotalPicture"],
        lPosLyrics: json["lPosLyrics"],
        lPosSync: json["lPosSync"],
        lPosPicture: json["lPosPicture"],
        nStartPos: json["nStartPos"],
        nEndPos: json["nEndPos"],
        lPosStream: json["lPosStream"],
        lLenStream: json["lLenStream"],
      );

  Map<String, dynamic> toJson() => {
        "byteVersion": byteVersion,
        "nTotalLyrics": nTotalLyrics,
        "nTotalPicture": nTotalPicture,
        "lPosLyrics": lPosLyrics,
        "lPosSync": lPosSync,
        "lPosPicture": lPosPicture,
        "nStartPos": nStartPos,
        "nEndPos": nEndPos,
        "lPosStream": lPosStream,
        "lLenStream": lLenStream,
      };
}

class Ltag {
  List<String> pszLineLyrics;

  Ltag({
    required this.pszLineLyrics,
  });

  factory Ltag.fromJson(Map<String, dynamic> json) => Ltag(
        pszLineLyrics: List<String>.from(json["pszLineLyrics"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "pszLineLyrics": List<dynamic>.from(pszLineLyrics.map((x) => x)),
      };
}

class Ltaginfo {
  String cSongId;
  String cTitle1;
  String cTitle2;
  String cAuthor;
  String cLyricsAuthor;
  String cSinger;
  String bChorus;
  String nYear;
  String nType1;
  String nType2;
  dynamic cSex;

  Ltaginfo({
    required this.cSongId,
    required this.cTitle1,
    required this.cTitle2,
    required this.cAuthor,
    required this.cLyricsAuthor,
    required this.cSinger,
    required this.bChorus,
    required this.nYear,
    required this.nType1,
    required this.nType2,
    required this.cSex,
  });

  factory Ltaginfo.fromJson(Map<String, dynamic> json) => Ltaginfo(
        cSongId: json["cSongID"],
        cTitle1: json["cTitle1"],
        cTitle2: json["cTitle2"],
        cAuthor: json["cAuthor"],
        cLyricsAuthor: json["cLyricsAuthor"],
        cSinger: json["cSinger"],
        bChorus: json["bChorus"],
        nYear: json["nYear"],
        nType1: json["nType1"],
        nType2: json["nType2"],
        cSex: json["cSex"],
      );

  Map<String, dynamic> toJson() => {
        "cSongID": cSongId,
        "cTitle1": cTitle1,
        "cTitle2": cTitle2,
        "cAuthor": cAuthor,
        "cLyricsAuthor": cLyricsAuthor,
        "cSinger": cSinger,
        "bChorus": bChorus,
        "nYear": nYear,
        "nType1": nType1,
        "nType2": nType2,
        "cSex": cSex,
      };
}

class Stag {
  List<Record> record;

  Stag({
    required this.record,
  });

  factory Stag.fromJson(Map<String, dynamic> json) => Stag(
        record:
            List<Record>.from(json["RECORD"].map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "RECORD": List<dynamic>.from(record.map((x) => x.toJson())),
      };
}

class Record {
  String lTimeSyncStart;
  String lTimeSyncEnd;
  String nPosLyrics;
  String nPosLen;
  String nPosOneLine;
  String nLineDisplay;
  String nAttribute;
  String bNextDisplay;

  Record({
    required this.lTimeSyncStart,
    required this.lTimeSyncEnd,
    required this.nPosLyrics,
    required this.nPosLen,
    required this.nPosOneLine,
    required this.nLineDisplay,
    required this.nAttribute,
    required this.bNextDisplay,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        lTimeSyncStart: json["lTimeSyncStart"],
        lTimeSyncEnd: json["lTimeSyncEnd"],
        nPosLyrics: json["nPosLyrics"],
        nPosLen: json["nPosLen"],
        nPosOneLine: json["nPosOneLine"],
        nLineDisplay: json["nLineDisplay"],
        nAttribute: json["nAttribute"],
        bNextDisplay: json["bNextDisplay"],
      );

  Map<String, dynamic> toJson() => {
        "lTimeSyncStart": lTimeSyncStart,
        "lTimeSyncEnd": lTimeSyncEnd,
        "nPosLyrics": nPosLyrics,
        "nPosLen": nPosLen,
        "nPosOneLine": nPosOneLine,
        "nLineDisplay": nLineDisplay,
        "nAttribute": nAttribute,
        "bNextDisplay": bNextDisplay,
      };
}
