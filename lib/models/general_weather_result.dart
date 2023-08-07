class GeneralWeatherResult {
  String? date;
  String? day;
  String? icon;
  String? description;
  String? status;
  String? degree;
  String? min;
  String? max;
  String? night;
  String? humidity;

  GeneralWeatherResult(
      {this.date,
        this.day,
        this.icon,
        this.description,
        this.status,
        this.degree,
        this.min,
        this.max,
        this.night,
        this.humidity});

  GeneralWeatherResult.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    icon = json['icon'];
    description = json['description'];
    status = json['status'];
    degree = json['degree'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['day'] = this.day;
    data['icon'] = this.icon;
    data['description'] = this.description;
    data['status'] = this.status;
    data['degree'] = this.degree;
    data['min'] = this.min;
    data['max'] = this.max;
    data['night'] = this.night;
    data['humidity'] = this.humidity;
    return data;
  }
}