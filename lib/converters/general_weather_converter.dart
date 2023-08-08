import 'package:news/models/general_weather_result.dart';

class GeneralWeatherConverter {
  bool? success;
  List<GeneralWeatherResult>? result;

  GeneralWeatherConverter({this.success, this.result});

  GeneralWeatherConverter.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = List<GeneralWeatherResult>.from(
        json['result'].map((data) => GeneralWeatherResult.fromJson(data)),
      );
    } else {
      result = [];
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