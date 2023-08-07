class GeneralExchangeRateResult {
  String? code;
  String? name;
  int? rate;
  String? calculatedstr;
  int? calculated;

  GeneralExchangeRateResult({
    this.code,
    this.name,
    this.rate,
    this.calculatedstr,
    this.calculated
  });

  GeneralExchangeRateResult.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    rate = json['rate'];
    calculatedstr = json['calculatedstr'];
    calculated = json['calculated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['calculatedstr'] = this.calculatedstr;
    data['calculated'] = this.calculated;
    return data;
  }
}