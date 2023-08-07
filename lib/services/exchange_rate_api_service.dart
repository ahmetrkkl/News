import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/converters/general_pharmacy_converter.dart';
import 'package:news/models/general_pharmacy_result.dart';
import '../converters/general_exchange_rate_converter.dart';
import '../models/general_exchange_rate_result.dart';
import '../util/constant.dart' as constants;

class ExchangeRateApiService {
  ExchangeRateApiService();

  String apiKey = constants.apiKey;
  String apiUrl = constants.generalExchangeRateUrl;

  Future<List<GeneralExchangeRateResult>> fetchExchangeRate() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'authorization': apiKey, 'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      GeneralExchangeRateConverter generalExchangeRateConverter =
      GeneralExchangeRateConverter.fromJson(jsonData);
      return generalExchangeRateConverter.result ?? [];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
