import 'package:yelody_app/models/playlist/getsongs_byplaylistid_model.dart';

class GetPlaylistByUserId {
  bool? success;
  String? message;
  List<PlayListData>? data;

  GetPlaylistByUserId({this.success, this.message, this.data});

  GetPlaylistByUserId.fromJson(
    Map<String, dynamic> json, {
    bool imageHai = true,
  }) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlayListData>[];
      json['data'].forEach((v) {
        data!.add(PlayListData.fromJson(v, imageHai: false));
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

// class DataGetPlaylistByUserId {
//   String? userPlaylistId;
//   String? name;
//   String? image;
//   AppUserData? user;
//   List<SongData>? songs;
//   String? createdDate;
//   bool? favourite;

//   DataGetPlaylistByUserId(
//       {this.userPlaylistId,
//       this.name,
//       this.image,
//       this.user,
//       this.songs,
//       this.createdDate,
//       this.favourite});

//   DataGetPlaylistByUserId.fromJson(Map<String, dynamic> json) {
//     userPlaylistId = json['userPlaylistId'];
//     name = json['name'];
//     image = json['image'];
//     user = json['user'] != null
//         ? AppUserData.fromJson(
//             json['user'], 
//           )
//         : null;
//     if (json['songs'] != null) {
//       songs = <SongData>[];
//       json['songs'].forEach((v) {
//         songs!.add(SongData.fromJson(v, imageHai: true));
//       });
//     }
//     createdDate = json['createdDate'];
//     favourite = json['favourite'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['userPlaylistId'] = userPlaylistId;
//     data['name'] = name;
//     data['image'] = image;
//     if (user != null) {
//       data['user'] = user!.toJson();
//     }
//     if (songs != null) {
//       data['songs'] = songs!.map((v) => v.toJson()).toList();
//     }
//     data['createdDate'] = createdDate;
//     data['favourite'] = favourite;
//     return data;
//   }
// }

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
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['userId'] = userId;
//     data['userName'] = userName;
//     data['email'] = email;
//     data['password'] = password;
//     data['otp'] = otp;
//     data['otpRequestedTime'] = otpRequestedTime;
//     data['description'] = description;
//     data['lastVisitDate'] = lastVisitDate;
//     data['registrationDate'] = registrationDate;
//     data['yeloPoints'] = yeloPoints;
//     data['image'] = image;
//     data['profileComplete'] = profileComplete;
//     data['interestComplete'] = interestComplete;
//     data['type'] = type;
//     return data;
//   }
// }

// class SongsPlaylistByUserId {
//   String? songId;
//   String? name;
//   String? description;
//   int? rank;
//   String? artistName;
//   String? lyricsTxt;
//   String? lyricsXml;
//   String? image;

//   SongsPlaylistByUserId(
//       {this.songId,
//       this.name,
//       this.description,
//       this.rank,
//       this.artistName,
//       this.lyricsTxt,
//       this.lyricsXml,
//       this.image});

//   SongsPlaylistByUserId.fromJson(Map<String, dynamic> json) {
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
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['songId'] = songId;
//     data['name'] = name;
//     data['description'] = description;
//     data['rank'] = rank;
//     data['artistName'] = artistName;
//     data['lyrics_txt'] = lyricsTxt;
//     data['lyrics_xml'] = lyricsXml;
//     data['image'] = image;
//     return data;
//   }
// }
