import 'package:news/models/general_pharmacy_result.dart';

class GeneralPharmacyConverter {
  bool? success;
  List<GeneralPharmacyResult>? result;

  GeneralPharmacyConverter({this.success, this.result});

  GeneralPharmacyConverter.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <GeneralPharmacyResult>[];
      json['result'].forEach((v) {
        result!.add(GeneralPharmacyResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
