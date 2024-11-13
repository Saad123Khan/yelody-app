import 'package:equatable/equatable.dart';

class KeywordModel extends Equatable {
  String? keywordId;
  String? name;

  KeywordModel({this.keywordId, this.name});

  KeywordModel.fromJson(Map<String, dynamic> json) {
    keywordId = json['keywordId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keywordId'] = keywordId;
    data['name'] = name;
    return data;
  }

  @override
  List<Object?> get props => [keywordId, name];
}
