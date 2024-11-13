class SongsList {
  bool? success;
  String? message;
  List<SongData>? data;

  SongsList({this.success, this.message, this.data});

  SongsList.fromJson(Map<String, dynamic> json) {
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

class SongData {
  String? songId;
  String? name;
  String? description;
  int? rank;
  String? artistName;
  String? lyricsTxt;
  String? lyricsXml;
  int? viewCount;
  String? location;
  dynamic ageGroup;
  // List<String>? keywords;
  String? genre;
  String? chart;
  String? imageFile;
  dynamic songFile;

  SongData(
      {this.songId,
      this.name,
      this.location,
      this.description,
      this.rank,
      this.artistName,
      this.lyricsTxt,
      this.lyricsXml,
      this.viewCount,
      this.ageGroup,
      // this.keywords,
      this.genre,
      this.chart,
      this.imageFile,
      this.songFile});

  SongData.fromJson(Map<String, dynamic> json, {bool imageHai = false}) {
    songId = json['songId'];
    name = json['name'];
    description = json['description'];
    rank = json['rank'];
    artistName = json['artistName'];
    location = json['location'];
    lyricsTxt = imageHai ? json['lyrics_txt'] : json['lyricsTxt'];
    lyricsXml = imageHai ? json['lyrics_xml'] : json['lyricsXml'];
    viewCount = json['viewCount'];
    ageGroup = json['ageGroup'];
    // keywords = json['keywords'].cast<String>();
    genre = json['genre'];
    chart = json['chart'];
    imageFile = imageHai ? json['image'] : json['imageFile'];
    songFile = json['songFile'];
  }

  Map<String, dynamic> toJson({bool imageHai = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['songId'] = songId;
    data['name'] = name;
    data['description'] = description;
    data['rank'] = rank;
    data['artistName'] = artistName;
    imageHai ? data['lyrics_txt'] = lyricsTxt : data['lyricsTxt'] = lyricsTxt;
    imageHai ? data['lyrics_xml'] = lyricsXml : data['lyricsXml'] = lyricsXml;
    data['viewCount'] = viewCount;
    data['ageGroup'] = ageGroup;
    data['genre'] = genre;
    data['chart'] = chart;
    imageHai ? data['image'] = imageFile : data['imageFile'] = imageFile;
    data['songFile'] = songFile;
    return data;
  }
}
