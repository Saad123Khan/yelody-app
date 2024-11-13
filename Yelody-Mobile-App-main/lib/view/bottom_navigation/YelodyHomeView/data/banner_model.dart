class BannerModel {
  bool? success;
  String? message;
  List<BannerData>? data;

  BannerModel({this.success, this.message, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add(new BannerData.fromJson(v));
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

class BannerData {
  String? bannerId;
  String? location;
  String? language;
  String? url;
  String? image;

  BannerData(
      {this.bannerId, this.location, this.language, this.url, this.image});

  BannerData.fromJson(Map<String, dynamic> json) {
    bannerId = json['bannerId'];
    location = json['location'];
    language = json['language'];
    url = json['url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bannerId'] = bannerId;
    data['location'] = location;
    data['language'] = language;
    data['url'] = url;
    data['image'] = image;
    return data;
  }
}
