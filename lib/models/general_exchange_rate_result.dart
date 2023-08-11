class ExchangeRateBody {
  bool success;
  ExchangeRateResult result;

  ExchangeRateBody({
    required this.success,
    required this.result,
  });
}

class ExchangeRateResult {
  String? base;
  String? lastupdate;
  List<ExchangeRateData>? data;

  ExchangeRateResult({
    required this.base,
    required this.lastupdate,
    required this.data,
  });

  ExchangeRateResult.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    lastupdate = json['lastupdate'];
    if (json['data'] != null) {
      data = <ExchangeRateData>[];
      json['data'].forEach((v) {
        data!.add(ExchangeRateData.fromJson(v));
      });
    }
  }
}

class ExchangeRateData {
  String? code;
  String? name;
  double? rate;
  String? calculatedstr;
  double? calculated;

  ExchangeRateData({
    required this.code,
    required this.name,
    required this.rate,
    required this.calculatedstr,
    required this.calculated,
  });

  ExchangeRateData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    rate = json['rate'].toDouble();
    calculatedstr = json['calculatedstr'];
    calculated = json['calculated'].toDouble();
  }
}
