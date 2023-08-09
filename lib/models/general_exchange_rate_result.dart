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
    this.calculated,
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
class Data {
  String? base;
  String? lastupdate;
  List<GeneralExchangeRateResult>? data;

  Data({this.base, this.lastupdate, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    lastupdate = json['lastupdate'];
    if (json['data'] != null) {
      data = <GeneralExchangeRateResult>[];
      json['data'].forEach((v) {
        data!.add(new GeneralExchangeRateResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base'] = this.base;
    data['lastupdate'] = this.lastupdate;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
