class UserSingHistory {
  bool? success;
  String? message;
  List<SongHistoryData>? data;

  UserSingHistory({this.success, this.message, this.data});

  UserSingHistory.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SongHistoryData>[];
      json['data'].forEach((v) {
        data!.add(SongHistoryData.fromJson(v));
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

class SongHistoryData {
  dynamic? singHistoryId;
  User? user;
  Song? songs;
  dynamic? recordingDate;
  dynamic? score;
  dynamic? lyrics;
  dynamic? file;

  SongHistoryData(
      {this.singHistoryId,
      this.lyrics,
      this.file,
      this.score,
      this.songs,
      this.user,
      this.recordingDate});

  SongHistoryData.fromJson(Map<String, dynamic> json) {
    singHistoryId = json['singHistoryId'];
    lyrics = json['lyrics'];
    file = json['file'];
    score = json['score'];
    songs = json['songs'] != null ? new Song.fromJson(json['songs']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    recordingDate = json['recordingDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['singHistoryId'] = this.singHistoryId;
    data['lyrics'] = this.lyrics;
    data['file'] = this.file;
    data['score'] = this.score;
    if (this.songs != null) {
      data['songs'] = this.songs!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['recordingDate'] = this.recordingDate;
    return data;
  }
}

class User {
  String? userId;

  User({
    this.userId,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    return data;
  }
}

class Song {
  String? songId;
  String? name;
  String? description;
  String? location;
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
  Null? songFile;

  Song(
      {this.songId,
      this.name,
      this.description,
      this.location,
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

  Song.fromJson(Map<String, dynamic> json) {
    songId = json['songId'];
    name = json['name'];
    description = json['description'];
    location = json['location'];
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
    data['location'] = this.location;
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
