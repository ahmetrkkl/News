import 'package:news/models/general_news_result.dart';

class GeneralNewsConverter {
  bool? success;
  List<GeneralNewsResult>? result;

  GeneralNewsConverter({this.success, this.result});

  GeneralNewsConverter.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <GeneralNewsResult>[];
      json['result'].forEach((v) {
        result!.add(GeneralNewsResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
