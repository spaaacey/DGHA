import 'dart:convert';

import 'package:dgha/misc/data.dart';
import 'package:dgha/misc/helper.dart';
import 'package:dgha/models/place.dart';
import 'package:dgha/models/search_response.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class PlaceService {

  static Future<bool> getPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    bool hasAsked = false;

    while (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse &&
        hasAsked == false) {
      permission = await Geolocator.requestPermission();
      hasAsked = true;
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  static Future<String?> getState() async {
    // Geocoding (placemarks) requires the geocoding package; returning null here
    // triggers the fallback to "Victoria" in getRecommendedPlaces.
    return null;
  }

  static Future<List<PlaceData>> getRecommendedPlaces() async {
    // getState() requires a physical device; hardcode to Victoria for testing
    final String state = "Victoria";

    String url = '${Data.rootTestingUrl}/Locations/recommend?state=$state';
    http.Response res = await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      return PlaceData.decodePlaceDataList(res.body);
    }
    return <PlaceData>[];
  }

  static Future<SearchPlace> getSearchedPlaces(String query, String nextPageToken) async {
    String formattedQuery = Helper().formatStringForQuery(query);
    String url = '${Data.rootTestingUrl}/Locations/search?query=$formattedQuery&nextPageToken=$nextPageToken';
    http.Response res = await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      SearchPlace spr = SearchPlace.decodePlaceReponseFromJson(res.body);
      spr.nextPageToken = spr.nextPageToken ?? '';
      return spr;
    } else {
      return SearchPlace(places: <PlaceData>[], nextPageToken: '');
    }
  }

  static Future<PlaceData?> getPlaceRatingById(String placeId) async {
    String url = "${Data.rootTestingUrl}/Locations/placeId/$placeId";
    http.Response res = await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      Map<String, dynamic> decodeJson = jsonDecode(res.body);
      return PlaceData.fromJson(decodeJson);
    }

    return null;
  }
}
