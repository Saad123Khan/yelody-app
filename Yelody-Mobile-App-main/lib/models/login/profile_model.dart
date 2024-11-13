import 'package:yelody_app/models/age_group/age_group_model.dart';
import 'package:yelody_app/models/genre/genre_model.dart';
import 'package:yelody_app/models/keywords/keyword_model.dart';
import 'package:yelody_app/models/login/user_model.dart';

class ProfileRes {
  bool? success;
  String? message;
  AppUserProfileData? data;

  ProfileRes({this.success, this.message, this.data});

  ProfileRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? AppUserProfileData.fromJson(json['data']) : null;
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

class AppUserProfileData {
  AppUserData? userDetails;
  List<AgeGroupModel>? ageGroup;
  List<GenreModel>? genre;
  List<KeywordModel>? keyword;

  AppUserProfileData(
      {this.userDetails, this.ageGroup, this.genre, this.keyword});

  AppUserProfileData.fromJson(Map<String, dynamic> json) {
    userDetails = json['userDetails'] != null
        ? AppUserData.fromJson(json['userDetails'])
        : null;
    if (json['ageGroup'] != null) {
      ageGroup = <AgeGroupModel>[];
      json['ageGroup'].forEach((v) {
        ageGroup!.add(AgeGroupModel.fromJson(v));
      });
    }
    if (json['genre'] != null) {
      genre = <GenreModel>[];
      json['genre'].forEach((v) {
        genre!.add(GenreModel.fromJson(v));
      });
    }
    if (json['keyword'] != null) {
      keyword = <KeywordModel>[];
      json['keyword'].forEach((v) {
        keyword!.add(KeywordModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userDetails != null) {
      data['userDetails'] = userDetails!.toJson();
    }
    if (ageGroup != null) {
      data['ageGroup'] = ageGroup!.map((v) => v.toJson()).toList();
    }
    if (genre != null) {
      data['genre'] = genre!.map((v) => v.toJson()).toList();
    }
    if (keyword != null) {
      data['keyword'] = keyword!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
