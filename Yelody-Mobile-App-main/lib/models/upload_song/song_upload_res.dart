class UploadSongRes {
  String? message;
  String? resultText;
  double? similarityScore;

  UploadSongRes({this.message, this.resultText, this.similarityScore});

  UploadSongRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    resultText = json['result_text'];
    similarityScore = json['similarity_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['result_text'] = resultText;
    data['similarity_score'] = similarityScore;
    return data;
  }
}
