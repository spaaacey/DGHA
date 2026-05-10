import 'package:dgha/models/place.dart';

class ApiPlaceResult {
  dynamic result;
  PlaceData? value;

  ApiPlaceResult({this.result, this.value});

  ApiPlaceResult.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    value = json['value'] != null ? PlaceData.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = this.result;
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}
