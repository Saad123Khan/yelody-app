import 'package:yelody_app/models/songs/song_model.dart';

class GetChartSongByIdModel {
  bool? success;
  String? message;
  DataCharts? data;

  GetChartSongByIdModel({this.success, this.message, this.data});

  GetChartSongByIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new DataCharts.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataCharts {
  String? chartId;
  String? name;
  String? title;
  String? description;
  bool? newFlag;
  String? region;
  int? rank;
  int? viewCount;
  String? image;
  Null? songIds;
  List<SongData>? songs;

  DataCharts(
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

  DataCharts.fromJson(Map<String, dynamic> json) {
    chartId = json['chartId'];
    name = json['name'];
    title = json['title'];
    description = json['description'];
    newFlag = json['newFlag'];
    region = json['region'];
    rank = json['rank'];
    viewCount = json['viewCount'];
    image = json['image'];
    songIds = json['songIds'];
    if (json['songs'] != null) {
      songs = <SongData>[];
      json['songs'].forEach((v) {
        songs!.add(new SongData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chartId'] = this.chartId;
    data['name'] = this.name;
    data['title'] = this.title;
    data['description'] = this.description;
    data['newFlag'] = this.newFlag;
    data['region'] = this.region;
    data['rank'] = this.rank;
    data['viewCount'] = this.viewCount;
    data['image'] = this.image;
    data['songIds'] = this.songIds;
    if (this.songs != null) {
      data['songs'] = this.songs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SongsChartsbyId {
  String? songId;
  String? name;
  String? description;
  int? rank;
  String? artistName;
  String? lyricsTxt;
  String? lyricsXml;
  int? viewCount;
  String? ageGroup;
  List<String>? keywords;
  String? genre;
  Null? chart;
  String? imageFile;
  Null? songFile;

  SongsChartsbyId(
      {this.songId,
      this.name,
      this.description,
      this.rank,
      this.artistName,
      this.lyricsTxt,
      this.lyricsXml,
      this.viewCount,
      this.ageGroup,
      this.keywords,
      this.genre,
      this.chart,
      this.imageFile,
      this.songFile});

  SongsChartsbyId.fromJson(Map<String, dynamic> json) {
    songId = json['songId'];
    name = json['name'];
    description = json['description'];
    rank = json['rank'];
    artistName = json['artistName'];
    lyricsTxt = json['lyricsTxt'];
    lyricsXml = json['lyricsXml'];
    viewCount = json['viewCount'];
    ageGroup = json['ageGroup'];
    keywords = json['keywords'].cast<String>();
    genre = json['genre'];
    chart = json['chart'];
    imageFile = json['imageFile'];
    songFile = json['songFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['songId'] = this.songId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['rank'] = this.rank;
    data['artistName'] = this.artistName;
    data['lyricsTxt'] = this.lyricsTxt;
    data['lyricsXml'] = this.lyricsXml;
    data['viewCount'] = this.viewCount;
    data['ageGroup'] = this.ageGroup;
    data['keywords'] = this.keywords;
    data['genre'] = this.genre;
    data['chart'] = this.chart;
    data['imageFile'] = this.imageFile;
    data['songFile'] = this.songFile;
    return data;
  }
}