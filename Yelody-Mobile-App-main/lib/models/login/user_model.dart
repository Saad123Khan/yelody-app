class AppLoginResponse {
  bool? success;
  String? message;
  AppUserData? data;

  AppLoginResponse({this.success, this.message, this.data});

  AppLoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? AppUserData.fromJson(json['data']) : null;
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

class AppUserData {
  String? userId;
  String? userName;
  String? email;
  // ? password;
  dynamic otp;
  dynamic otpRequestedTime;
  String? description;
  String? lastVisitDate;
  String? registrationDate;
  dynamic yeloPoints;
  String? image;
  bool? profileComplete;
  bool? interestComplete;
  String? type;

  AppUserData(
      {this.userId,
      this.userName,
      this.email,
      this.otp,
      this.otpRequestedTime,
      this.description,
      this.lastVisitDate,
      this.registrationDate,
      this.yeloPoints,
      this.image,
      this.profileComplete,
      this.interestComplete,
      this.type});

  AppUserData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    otp = json['otp'];
    otpRequestedTime = json['otpRequestedTime'];
    description = json['description'];
    lastVisitDate = json['lastVisitDate'];
    registrationDate = json['registrationDate'];
    yeloPoints = json['yeloPoints'];
    image = json['image'];
    profileComplete = json['profileComplete'];
    interestComplete = json['interestComplete'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['otp'] = otp;
    data['otpRequestedTime'] = otpRequestedTime;
    data['description'] = description;
    data['lastVisitDate'] = lastVisitDate;
    data['registrationDate'] = registrationDate;
    data['yeloPoints'] = yeloPoints;
    data['image'] = image;
    data['profileComplete'] = profileComplete;
    data['interestComplete'] = interestComplete;
    data['type'] = type;
    return data;
  }
}
