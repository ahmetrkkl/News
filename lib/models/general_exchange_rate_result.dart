class GeneralExchangeRateResult{
  String? name;
  String? buying;
  String? selling;

  GeneralExchangeRateResult({this.name, this.buying, this.selling});

  GeneralExchangeRateResult.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    buying = json['buying'];
    selling = json['selling'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['buying'] = this.buying;
    data['selling'] = this.selling;
    return data;
  }
}