class GeneralNewsResult {
  String? key;
  String? url;
  String? description;
  String? image;
  String? name;
  String? source;

  GeneralNewsResult(
      {this.key,
        this.url,
        this.description,
        this.image,
        this.name,
        this.source});

  GeneralNewsResult.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
    description = json['description'];
    image = json['image'];
    name = json['name'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['url'] = url;
    data['description'] = description;
    data['image'] = image;
    data['name'] = name;
    data['source'] = source;
    return data;
  }
}
