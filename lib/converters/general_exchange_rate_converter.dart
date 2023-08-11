import '../models/general_exchange_rate_result.dart';

class GeneralExchangeRateConverter {
  bool? success;
  ExchangeRateResult? result;

  GeneralExchangeRateConverter({this.success, this.result});

  GeneralExchangeRateConverter.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = json['result'] != null
        ? ExchangeRateResult?.fromJson(json['result'])
        : null;
  }
}

