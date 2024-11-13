import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  String? genreId;
  String? type;

  GenreModel({this.genreId, this.type});

  GenreModel.fromJson(Map<String, dynamic> json) {
    genreId = json['genreId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genreId'] = genreId;
    data['type'] = type;
    return data;
  }

  @override
  List<Object?> get props => [genreId, type];
}
