import 'package:get/get.dart';
import 'package:yelody_app/models/login/user_model.dart';
import 'package:yelody_app/models/songs/song_model.dart';

class GetSongByPlaylistIdModel {
  bool? success;
  String? message;
  PlayListData? data;

  GetSongByPlaylistIdModel({this.success, this.message, this.data});

  GetSongByPlaylistIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? PlayListData.fromJson(json['data']) : null;
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

class PlayListData {
  String? userPlaylistId;
  String? name;
  String? image;
  AppUserData? user;
  RxList<SongData>? songs;
  String? createdDate;
  bool? favourite;

  PlayListData(
      {this.userPlaylistId,
      this.name,
      this.image,
      this.user,
      this.songs,
      this.createdDate,
      this.favourite});

  PlayListData.fromJson(
    Map<String, dynamic> json, {
    bool imageHai = true,
  }) {
    userPlaylistId = json['userPlaylistId'];
    name = json['name'];
    image = json['image'];
    user = json['user'] != null ? AppUserData.fromJson(json['user']) : null;
    if (json['songs'] != null) {
      songs = <SongData>[].obs;
      json['songs'].forEach((v) {
        songs!.add(
          SongData.fromJson(v, imageHai: false),
        );
      });
    } else {
      songs = <SongData>[].obs;
    }
    createdDate = json['createdDate'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson({bool imageHai = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userPlaylistId'] = userPlaylistId;
    data['name'] = name;
    data['image'] = image;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (songs != null) {
      data['songs'] = songs!.map((v) => v.toJson(imageHai: imageHai)).toList();
    }
    data['createdDate'] = createdDate;
    data['favourite'] = favourite;
    return data;
  }
}

// class User {
//   String? userId;
//   String? userName;
//   String? email;
//   Null? password;
//   Null? otp;
//   Null? otpRequestedTime;
//   String? description;
//   String? lastVisitDate;
//   String? registrationDate;
//   dynamic? yeloPoints;
//   String? image;
//   bool? profileComplete;
//   bool? interestComplete;
//   String? type;

//   User(
//       {this.userId,
//       this.userName,
//       this.email,
//       this.password,
//       this.otp,
//       this.otpRequestedTime,
//       this.description,
//       this.lastVisitDate,
//       this.registrationDate,
//       this.yeloPoints,
//       this.image,
//       this.profileComplete,
//       this.interestComplete,
//       this.type});

//   User.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     userName = json['userName'];
//     email = json['email'];
//     password = json['password'];
//     otp = json['otp'];
//     otpRequestedTime = json['otpRequestedTime'];
//     description = json['description'];
//     lastVisitDate = json['lastVisitDate'];
//     registrationDate = json['registrationDate'];
//     yeloPoints = json['yeloPoints'];
//     image = json['image'];
//     profileComplete = json['profileComplete'];
//     interestComplete = json['interestComplete'];
//     type = json['type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['userName'] = this.userName;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['otp'] = this.otp;
//     data['otpRequestedTime'] = this.otpRequestedTime;
//     data['description'] = this.description;
//     data['lastVisitDate'] = this.lastVisitDate;
//     data['registrationDate'] = this.registrationDate;
//     data['yeloPoints'] = this.yeloPoints;
//     data['image'] = this.image;
//     data['profileComplete'] = this.profileComplete;
//     data['interestComplete'] = this.interestComplete;
//     data['type'] = this.type;
//     return data;
//   }
// }

// class Songs {
//   String? songId;
//   String? name;
//   String? description;
//   int? rank;
//   String? artistName;
//   String? lyricsTxt;
//   String? lyricsXml;
//   String? image;

//   Songs(
//       {this.songId,
//       this.name,
//       this.description,
//       this.rank,
//       this.artistName,
//       this.lyricsTxt,
//       this.lyricsXml,
//       this.image});

//   Songs.fromJson(Map<String, dynamic> json) {
//     songId = json['songId'];
//     name = json['name'];
//     description = json['description'];
//     rank = json['rank'];
//     artistName = json['artistName'];
//     lyricsTxt = json['lyrics_txt'];
//     lyricsXml = json['lyrics_xml'];
//     image = json['image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['songId'] = this.songId;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['rank'] = this.rank;
//     data['artistName'] = this.artistName;
//     data['lyrics_txt'] = this.lyricsTxt;
//     data['lyrics_xml'] = this.lyricsXml;
//     data['image'] = this.image;
//     return data;
//   }
// }
