import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/converters/general_news_converter.dart';
import '../models/general_news_result.dart';
import '../util/constant.dart' as constants;

class NewsApiService {
  NewsApiService();

  String apiKey = constants.apiKey;
  String apiUrl = constants.generalNewsUrl;

  Future<List<GeneralNewsResult>> fetchNews() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'authorization': apiKey, 'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      GeneralNewsConverter generalNewsConverter =
          GeneralNewsConverter.fromJson(jsonData);
      return generalNewsConverter.result ?? [];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
