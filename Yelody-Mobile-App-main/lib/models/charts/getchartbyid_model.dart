class GetChartByIdModel {
  bool? success;
  String? message;
  ChartDataById? data;

  GetChartByIdModel({this.success, this.message, this.data});

  GetChartByIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new ChartDataById.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ChartDataById {
  String? chartId;
  String? name;
  String? title;
  String? description;
  bool? newFlag;
  String? region;
  int? rank;
  int? viewCount;
  String? image;

  ChartDataById(
      {this.chartId,
      this.name,
      this.title,
      this.description,
      this.newFlag,
      this.region,
      this.rank,
      this.viewCount,
      this.image});

  ChartDataById.fromJson(Map<String, dynamic> json) {
    chartId = json['chartId'];
    name = json['name'];
    title = json['title'];
    description = json['description'];
    newFlag = json['newFlag'];
    region = json['region'];
    rank = json['rank'];
    viewCount = json['viewCount'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chartId'] = this.chartId;
    data['name'] = this.name;
    data['title'] = this.title;
    data['description'] = this.description;
    data['newFlag'] = this.newFlag;
    data['region'] = this.region;
    data['rank'] = this.rank;
    data['viewCount'] = this.viewCount;
    data['image'] = this.image;
    return data;
  }
}