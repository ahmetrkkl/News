import '../models/general_exchange_rate_result.dart';

class GeneralExchangeRateConverter {
  bool? success;
  List<GeneralExchangeRateResult>? result;

  GeneralExchangeRateConverter({this.success, this.result});

  GeneralExchangeRateConverter.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <GeneralExchangeRateResult>[];
      json['result'].forEach((v) {
        result!.add(GeneralExchangeRateResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}