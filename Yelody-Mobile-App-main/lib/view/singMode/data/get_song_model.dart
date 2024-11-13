class GetSongModel {
  String? songId;
  String? name;
  String? description;
  int? rank;
  String? artistName;
  String? lyricsTxt;
  String? lyricsXml;
  int? viewCount;
  String? ageGroup;
  dynamic keywords;
  String? genre;
  dynamic chart;
  String? imageFile;
  dynamic songFile;

  GetSongModel(
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

  GetSongModel.fromJson(Map<String, dynamic> json) {
    songId = json['songId'];
    name = json['name'];
    description = json['description'];
    rank = json['rank'];
    artistName = json['artistName'];
    lyricsTxt = json['lyricsTxt'];
    lyricsXml = json['lyricsXml'];
    viewCount = json['viewCount'];
    ageGroup = json['ageGroup'];
    keywords =  json['keywords'];
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
