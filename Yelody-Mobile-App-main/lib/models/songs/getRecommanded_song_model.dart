import 'package:yelody_app/models/songs/song_model.dart';

class GetRecommandedSongByuserIdModel {
  bool? success;
  String? message;
  List<SongData>? data;

  GetRecommandedSongByuserIdModel({this.success, this.message, this.data});

  GetRecommandedSongByuserIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SongData>[];
      json['data'].forEach((v) {
        data!.add(SongData.fromJson(
          v,
        ));
      });
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

// // class DataRecommandedSong {
//   String? songId;
//   String? name;
//   String? description;
//   int? rank;
//   String? artistName;
//   String? lyricsTxt;
//   String? lyricsXml;
//   int? viewCount;
//   String? ageGroup;
//   List<String>? keywords;
//   String? genre;
//   String? chart;
//   String? imageFile;
//   Null? songFile;

//   DataRecommandedSong(
//       {this.songId,
//       this.name,
//       this.description,
//       this.rank,
//       this.artistName,
//       this.lyricsTxt,
//       this.lyricsXml,
//       this.viewCount,
//       this.ageGroup,
//       this.keywords,
//       this.genre,
//       this.chart,
//       this.imageFile,
//       this.songFile});

//   DataRecommandedSong.fromJson(Map<String, dynamic> json) {
//     songId = json['songId'];
//     name = json['name'];
//     description = json['description'];
//     rank = json['rank'];
//     artistName = json['artistName'];
//     lyricsTxt = json['lyricsTxt'];
//     lyricsXml = json['lyricsXml'];
//     viewCount = json['viewCount'];
//     ageGroup = json['ageGroup'];
//     keywords = json['keywords'].cast<String>();
//     genre = json['genre'];
//     chart = json['chart'];
//     imageFile = json['imageFile'];
//     songFile = json['songFile'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['songId'] = this.songId;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['rank'] = this.rank;
//     data['artistName'] = this.artistName;
//     data['lyricsTxt'] = this.lyricsTxt;
//     data['lyricsXml'] = this.lyricsXml;
//     data['viewCount'] = this.viewCount;
//     data['ageGroup'] = this.ageGroup;
//     data['keywords'] = this.keywords;
//     data['genre'] = this.genre;
//     data['chart'] = this.chart;
//     data['imageFile'] = this.imageFile;
//     data['songFile'] = this.songFile;
//     return data;
//   }
// }