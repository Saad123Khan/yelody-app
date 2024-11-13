class GetSongByIdModel {
  bool? success;
  String? message;
  GetSongIdData? data;

  GetSongByIdModel({this.success, this.message, this.data});

  GetSongByIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? GetSongIdData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetSongIdData {
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
  String? chart;
  String? imageFile;
  dynamic songFile;

  GetSongIdData(
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

  GetSongIdData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['songId'] = songId;
    data['name'] = name;
    data['description'] = description;
    data['rank'] = rank;
    data['artistName'] = artistName;
    data['lyricsTxt'] = lyricsTxt;
    data['lyricsXml'] = lyricsXml;
    data['viewCount'] = viewCount;
    data['ageGroup'] = ageGroup;
    data['keywords'] = keywords;
    data['genre'] = genre;
    data['chart'] = chart;
    data['imageFile'] = imageFile;
    data['songFile'] = songFile;
    return data;
  }
}
