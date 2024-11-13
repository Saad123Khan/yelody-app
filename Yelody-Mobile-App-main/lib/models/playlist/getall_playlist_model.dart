class GetAllPlaylistModel {
  bool? success;
  String? message;
  List<DataAllPlaylist>? data;

  GetAllPlaylistModel({this.success, this.message, this.data});

  GetAllPlaylistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataAllPlaylist>[];
      json['data'].forEach((v) {
        data!.add(new DataAllPlaylist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataAllPlaylist {
  String? userPlaylistId;
  String? name;
  String? image;
  UserAllPlaylist? user;
  List<Songs>? songs;
  String? createdDate;
  bool? favourite;

  DataAllPlaylist(
      {this.userPlaylistId,
      this.name,
      this.image,
      this.user,
      this.songs,
      this.createdDate,
      this.favourite});

  DataAllPlaylist.fromJson(Map<String, dynamic> json) {
    userPlaylistId = json['userPlaylistId'];
    name = json['name'];
    image = json['image'];
    user = json['user'] != null ? new UserAllPlaylist.fromJson(json['user']) : null;
    if (json['songs'] != null) {
      songs = <Songs>[];
      json['songs'].forEach((v) {
        songs!.add(new Songs.fromJson(v));
      });
    }
    createdDate = json['createdDate'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userPlaylistId'] = this.userPlaylistId;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.songs != null) {
      data['songs'] = this.songs!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = this.createdDate;
    data['favourite'] = this.favourite;
    return data;
  }
}

class UserAllPlaylist {
  String? userId;
  String? userName;
  String? email;
  String? password;
  Null? otp;
  Null? otpRequestedTime;
  Null? description;
  String? lastVisitDate;
  String? registrationDate;
  int? yeloPoints;
  String? image;

  UserAllPlaylist(
      {this.userId,
      this.userName,
      this.email,
      this.password,
      this.otp,
      this.otpRequestedTime,
      this.description,
      this.lastVisitDate,
      this.registrationDate,
      this.yeloPoints,
      this.image});

  UserAllPlaylist.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    otpRequestedTime = json['otpRequestedTime'];
    description = json['description'];
    lastVisitDate = json['lastVisitDate'];
    registrationDate = json['registrationDate'];
    yeloPoints = json['yeloPoints'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['otpRequestedTime'] = this.otpRequestedTime;
    data['description'] = this.description;
    data['lastVisitDate'] = this.lastVisitDate;
    data['registrationDate'] = this.registrationDate;
    data['yeloPoints'] = this.yeloPoints;
    data['image'] = this.image;
    return data;
  }
}

class Songs {
  String? songId;
  String? name;
  String? description;
  int? rank;
  String? artistName;
  String? lyricsTxt;
  String? lyricsXml;
  String? image;

  Songs(
      {this.songId,
      this.name,
      this.description,
      this.rank,
      this.artistName,
      this.lyricsTxt,
      this.lyricsXml,
      this.image});

  Songs.fromJson(Map<String, dynamic> json) {
    songId = json['songId'];
    name = json['name'];
    description = json['description'];
    rank = json['rank'];
    artistName = json['artistName'];
    lyricsTxt = json['lyrics_txt'];
    lyricsXml = json['lyrics_xml'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['songId'] = this.songId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['rank'] = this.rank;
    data['artistName'] = this.artistName;
    data['lyrics_txt'] = this.lyricsTxt;
    data['lyrics_xml'] = this.lyricsXml;
    data['image'] = this.image;
    return data;
  }
}