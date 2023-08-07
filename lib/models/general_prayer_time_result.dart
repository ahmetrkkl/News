class GeneralPrayerTimeResult {
  String? saat;
  String? vakit;

  GeneralPrayerTimeResult(
      {this.saat,
        this.vakit
      });

  GeneralPrayerTimeResult.fromJson(Map<String, dynamic> json) {
    saat = json['saat'];
    vakit = json['vakit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['saat'] = this.saat;
    data['vakit'] = this.vakit;
    return data;
  }
}