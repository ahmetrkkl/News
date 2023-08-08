import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/general_weather_result.dart';
import '../converters/general_weather_converter.dart';
import '../util/constant.dart' as constants;

class WeatherApiService {
  WeatherApiService();

  String apiKey = constants.apiKey;
  String apiUrl = constants.generalWeatherUrl;

  Future<List<GeneralWeatherResult>> fetchWeather() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'authorization': apiKey, 'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      GeneralWeatherConverter generalWeatherConverter =
      GeneralWeatherConverter.fromJson(jsonData);
      return generalWeatherConverter.result ?? [];
    } else {
      throw Exception('Failed to load news');
    }
  }
}

