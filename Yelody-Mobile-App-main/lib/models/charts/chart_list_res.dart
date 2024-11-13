import 'package:yelody_app/models/songs/song_model.dart';

class ChartsList {
  bool? success;
  String? message;
  List<ChartData>? data;

  ChartsList({this.success, this.message, this.data});

  ChartsList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ChartData>[];
      json['data'].forEach((v) {
        data!.add(ChartData.fromJson(v));
      });
    } else {
      data = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChartData {
  String? chartId;
  String? name;
  String? title;
  String? description;
  bool? newFlag;
  String? region;
  int? rank;
  int? viewCount;
  String? image;
  List<String>? songIds;
  List<SongData>? songs;

  ChartData(
      {this.chartId,
      this.name,
      this.title,
      this.description,
      this.newFlag,
      this.region,
      this.rank,
      this.viewCount,
      this.image,
      this.songIds,
      this.songs});

  ChartData.fromJson(Map<String, dynamic> json) {
    chartId = json['chartId'];
    name = json['name'];
    title = json['title'];
    description = json['description'];
    newFlag = json['newFlag'];
    region = json['region'];
    rank = json['rank'];
    viewCount = json['viewCount'];
    image = json['image'];
    songIds = json['songIds'].cast<String>();
    if (json['songs'] != null) {
      songs = <SongData>[];
      json['songs'].forEach((v) {
        songs!.add(
          SongData.fromJson(v, imageHai: false),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chartId'] = chartId;
    data['name'] = name;
    data['title'] = title;
    data['description'] = description;
    data['newFlag'] = newFlag;
    data['region'] = region;
    data['rank'] = rank;
    data['viewCount'] = viewCount;
    data['image'] = image;
    data['songIds'] = songIds;
    if (songs != null) {
      data['songs'] = songs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class SongDataChart {
//   String? songId;
//   String? name;
//   String? description;
//   int? rank;
//   String? artistName;
//   String? lyricsTxt;
//   String? lyricsXml;
//   int? viewCount;
//   String? ageGroup;
//   // List<String>? keywords;
//   String? genre;
//   String? chart;
//   String? imageFile;
//   dynamic songFile;

//   SongDataChart(
//       {this.songId,
//       this.name,
//       this.description,
//       this.rank,
//       this.artistName,
//       this.lyricsTxt,
//       this.lyricsXml,
//       this.viewCount,
//       this.ageGroup,
//       // this.keywords,
//       this.genre,
//       this.chart,
//       this.imageFile,
//       this.songFile});

//   SongDataChart.fromJson(Map<String, dynamic> json, {bool imageHai = false}) {
//     songId = json['songId'];
//     name = json['name'];
//     description = json['description'];
//     rank = json['rank'];
//     artistName = json['artistName'];
//     lyricsTxt = imageHai ? json['lyrics_txt'] : json['lyricsTxt'];
//     lyricsXml = imageHai ? json['lyrics_xml'] : json['lyricsXml'];
//     viewCount = json['viewCount'];
//     ageGroup = json['ageGroup'];
//     // keywords = json['keywords'].cast<String>();
//     genre = json['genre'];
//     chart = json['chart'];
//     imageFile = imageHai ? json['image'] : json['imageFile'];
//     songFile = json['songFile'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['songId'] = songId;
//     data['name'] = name;
//     data['description'] = description;
//     data['rank'] = rank;
//     data['artistName'] = artistName;
//     data['lyricsTxt'] = lyricsTxt;
//     data['lyricsXml'] = lyricsXml;
//     data['viewCount'] = viewCount;
//     data['ageGroup'] = ageGroup;
//     // data['keywords'] = keywords;
//     data['genre'] = genre;
//     data['chart'] = chart;
//     data['imageFile'] = imageFile;
//     data['songFile'] = songFile;
//     return data;
//   }
// }
