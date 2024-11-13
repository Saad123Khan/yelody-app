import 'package:yelody_app/models/login/user_model.dart';
import 'package:yelody_app/models/songs/song_model.dart';

class SongQueList {
  bool? success;
  String? message;
  Data? data;

  SongQueList({this.success, this.message, this.data});

  SongQueList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? songQueueId;
  AppUserData? user;
  List<Items>? items;
  String? createdDate;

  Data({this.songQueueId, this.user, this.items, this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    songQueueId = json['songQueueId'];
    user = json['user'] != null
        ? AppUserData.fromJson(
            json['user'],
          )
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['songQueueId'] = songQueueId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = createdDate;
    return data;
  }
}

class Items {
  String? songQueueItemId;
  SongData? song;
  int? position;

  Items({this.songQueueItemId, this.song, this.position});

  Items.fromJson(Map<String, dynamic> json) {
    songQueueItemId = json['songQueueItemId'];
    song = json['song'] != null
        ? SongData.fromJson(json['song'], imageHai: true)
        : null;
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['songQueueItemId'] = songQueueItemId;
    if (song != null) {
      data['song'] = song!.toJson();
    }
    data['position'] = position;
    return data;
  }
}
