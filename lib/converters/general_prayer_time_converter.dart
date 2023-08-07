import 'package:news/models/general_prayer_time_result.dart';

class GeneralPrayerTimeConverter {
  bool? success;
  List<GeneralPrayerTimeResult>? result;

  GeneralPrayerTimeConverter({this.success, this.result});

  GeneralPrayerTimeConverter.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <GeneralPrayerTimeResult>[];
      json['result'].forEach((v) {
        result!.add(GeneralPrayerTimeResult.fromJson(v));
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