import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/news.dart';

import '../models/result.dart';

class NewsApiService {
  final String apiKey;
  final String apiUrl;

  NewsApiService({required this.apiKey, required this.apiUrl});

  Future<List<Result>> fetchNews() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer $apiKey'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      News news = News.fromJson(jsonData);
      return news.result ?? [];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
