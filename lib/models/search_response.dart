import 'dart:convert';
import 'package:dgha/models/place.dart';

class SearchPlace {
  List<PlaceData> places;
  String? nextPageToken;

  SearchPlace({
    List<PlaceData>? places,
    this.nextPageToken,
  }) : places = places ?? <PlaceData>[];

  factory SearchPlace.fromJson(Map<String, dynamic> json) => SearchPlace(
        places: List<PlaceData>.from(json["results"].map((x) => PlaceData.fromJson(x))),
        nextPageToken: json["nextPageToken"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(places.map((x) => x.toJson())),
        "nextPageToken": nextPageToken,
      };

  static SearchPlace decodePlaceReponseFromJson(String data) {
    return SearchPlace.fromJson(json.decode(data));
  }

  static String encodePlaceResponseToJson(SearchPlace data) {
    return json.encode(data.toJson());
  }
}
