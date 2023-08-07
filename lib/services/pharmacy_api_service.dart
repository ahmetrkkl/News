import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/converters/general_pharmacy_converter.dart';
import 'package:news/models/general_pharmacy_result.dart';
import '../util/constant.dart' as constants;

class PharmacyApiService {
  PharmacyApiService();

  String apiKey = constants.apiKey;
  String apiUrl = constants.generalPharmacyUrl;

  Future<List<GeneralPharmacyResult>> fetchPharmacy() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'authorization': apiKey, 'content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      GeneralPharmacyConverter generalPharmacyConverter =
      GeneralPharmacyConverter.fromJson(jsonData);
      return generalPharmacyConverter.result ?? [];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
