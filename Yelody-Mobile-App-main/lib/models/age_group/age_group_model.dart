import 'package:equatable/equatable.dart';

class AgeGroupModel extends Equatable {
  String? ageGroupId;
  String? name;

  AgeGroupModel({this.ageGroupId, this.name});

  AgeGroupModel.fromJson(Map<String, dynamic> json) {
    ageGroupId = json['ageGroupId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ageGroupId'] = ageGroupId;
    data['name'] = name;
    return data;
  }

  @override
  List<Object?> get props => [ageGroupId, name];
}
