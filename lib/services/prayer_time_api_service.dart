import 'dart:convert';
import 'package:http/http.dart' as http;
import '../converters/general_prayer_time_converter.dart';
import '../models/general_prayer_time_result.dart';
import '../util/constant.dart' as constants;

class PrayerTimeApiService {
  PrayerTimeApiService();

  String apiKey = constants.apiKey;
  String apiUrl = constants.generalPrayerTimeUrl;

  Future<List<GeneralPrayerTimeResult>> fetchPrayerTime() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'authorization': apiKey, 'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      GeneralPrayerTimeConverter converter =
      GeneralPrayerTimeConverter.fromJson(jsonData);
      return converter.result ?? [];
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}
