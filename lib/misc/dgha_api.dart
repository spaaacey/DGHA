import 'dart:convert';
import 'package:dgha/models/account.dart';
import 'package:dgha/models/review_place.dart';
import 'package:dgha/models/review.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:shared_preferences/shared_preferences.dart';

class DghaApi {
  static final String rootUrl = "https://dgha-api.azurewebsites.net";
  static oauth2.Client? currentClient;

  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('invalid token');

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) throw Exception('invalid payload');

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }

    return utf8.decode(base64Url.decode(output));
  }

  static Future<oauth2.Client?> signIn({String? email, String? password}) async {
    Uri tokenEndpoint = Uri.parse(
        "https://dgha-identityserver.azurewebsites.net/connect/token");
    String identifier = "ro.client";
    String secret = "secret";

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (email == null && password == null) {
      String? credString = prefs.getString('credentials');
      if (credString != null && credString != "") {
        oauth2.Credentials credentials = oauth2.Credentials.fromJson(credString);

        if (!credentials.isExpired) {
          currentClient = oauth2.Client(credentials,
              identifier: identifier, secret: secret);
          return currentClient;
        } else {
          signOut();
          return null;
        }
      } else {
        return null;
      }
    } else {
      currentClient = await oauth2.resourceOwnerPasswordGrant(
        tokenEndpoint,
        email!,
        password!,
        identifier: identifier,
        secret: secret,
      );

      prefs.setString('credentials', currentClient!.credentials.toJson());
      return currentClient;
    }
  }

  static void signOut() async {
    currentClient = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('credentials', "");
  }

  static Future<http.Response> postAccount(String email, String password) async {
    Map<String, dynamic> data = {"email": email, "password": password};

    return http.post(
      Uri.parse("$rootUrl/Accounts"),
      body: jsonEncode(data),
      headers: {"content-type": "application/json"},
    );
  }

  static Future<Account?> getAccount() async {
    if (currentClient == null) return null;

    http.Response response = await currentClient!.get(
      Uri.parse("$rootUrl/Accounts/${parseJwt(currentClient!.credentials.accessToken)['sub']}"),
      headers: {"content-type": "application/json"},
    );

    if (response.body == "") return Account();

    var decoded = jsonDecode(response.body);
    return Account(id: decoded['id'], email: decoded['email']);
  }

  static Future<http.Response?> deleteAccount() async {
    if (currentClient == null) return null;

    return currentClient!.delete(
      Uri.parse("$rootUrl/Accounts/${parseJwt(currentClient!.credentials.accessToken)['sub']}"),
      headers: {"content-type": "application/json"},
    );
  }

  static Future<http.Response?> updatePassword(String currentPassword, String newPassword) async {
    if (currentClient == null) return null;

    return currentClient!.put(
      Uri.parse("$rootUrl/Accounts/${parseJwt(currentClient!.credentials.accessToken)['sub']}/UpdatePassword?currentPassword=$currentPassword&newPassword=$newPassword"),
      headers: {"content-type": "application/json"},
    );
  }

  static Future<http.Response?> postComplaint(String placeID, String comment) async {
    if (currentClient == null) return null;

    Map<String, dynamic> data = {
      "userID": parseJwt(currentClient!.credentials.accessToken)['sub'],
      "placeID": placeID,
      "comment": comment,
    };

    return currentClient!.post(
      Uri.parse("$rootUrl/Complaints"),
      body: jsonEncode(data),
      headers: {"content-type": "application/json"},
    );
  }

  static Future<http.Response?> postReview(
    String placeId,
    int overallRating,
    int locationRating,
    int amenitiesRating,
    int serviceRating,
    String comment,
  ) async {
    if (currentClient == null) return null;

    Map<String, dynamic> data = {
      "userID": parseJwt(currentClient!.credentials.accessToken)['sub'],
      "placeID": placeId,
      "overallRating": overallRating,
      "locationRating": locationRating,
      "amentitiesRating": amenitiesRating,
      "serviceRating": serviceRating,
      "comment": comment,
    };

    return currentClient!.post(
      Uri.parse("$rootUrl/Reviews"),
      body: jsonEncode(data),
      headers: {"content-type": "application/json"},
    );
  }

  static Future<ReviewPlace> getReviewsFromPlaceId(String placeId) async {
    http.Response response = await http.get(
      Uri.parse("$rootUrl/Reviews/placeId/$placeId"),
      headers: {"content-type": "application/json"},
    );

    if (response.body == "" || response.statusCode != 200) {
      return ReviewPlace(reviews: <ReviewData>[]);
    }

    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<ReviewData> userReviews = <ReviewData>[];

    for (int i = 0; i < decoded['reviews'].length; i++) {
      userReviews.add(ReviewData(
        placeId: decoded['reviews'][i]['placeId'],
        userId: decoded['reviews'][i]['userId'],
        timeAdded: decoded['reviews'][i]['timeAdded'],
        comment: decoded['reviews'][i]['comment'],
        overallRating: decoded['reviews'][i]['overallRating'],
        locationRating: decoded['reviews'][i]['locationRating'],
        custServRating: decoded['reviews'][i]['serviceRating'],
        amenitiesRating: decoded['reviews'][i]['amenitiesRating'],
      ));
    }

    return ReviewPlace(
      averageRating: decoded['averageRating'].toDouble(),
      averageLocationRating: decoded['averageLocationRating'].toDouble(),
      averageAmenitiesRating: decoded['averageAmentitiesRating'].toDouble(),
      averageServiceRating: decoded['averageServiceRating'].toDouble(),
      count: decoded['count'],
      reviews: userReviews,
    );
  }

  static Future<List<ReviewData>> getReviewsFromPlaceIdAndSet(String placeId, int setIndex) async {
    http.Response response = await http.get(
      Uri.parse("$rootUrl/Reviews/placeId/$placeId/$setIndex"),
      headers: {"content-type": "application/json"},
    );

    if (response.body == "" || response.statusCode != 200) return <ReviewData>[];

    List<dynamic> decoded = jsonDecode(response.body);
    List<ReviewData> userReviews = <ReviewData>[];

    for (int i = 0; i < decoded.length; i++) {
      userReviews.add(ReviewData(
        placeId: decoded[i]['placeId'],
        userId: decoded[i]['userId'],
        timeAdded: decoded[i]['timeAdded'],
        comment: decoded[i]['comment'],
        overallRating: decoded[i]['overallRating'],
        locationRating: decoded[i]['locationRating'],
        custServRating: decoded[i]['serviceRating'],
        amenitiesRating: decoded[i]['amenitiesRating'],
      ));
    }

    return userReviews;
  }

  static Future<List<ReviewData>> getReviewsFromUser() async {
    http.Response response = await http.get(
      Uri.parse("$rootUrl/Reviews/userId/${parseJwt(currentClient!.credentials.accessToken)['sub']}"),
      headers: {"content-type": "application/json"},
    );

    if (response.body == "") return <ReviewData>[];

    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<ReviewData> userReviews = <ReviewData>[];

    for (int i = 0; i < decoded.length; i++) {
      userReviews.add(ReviewData(
        placeId: decoded[i]['placeId'],
        userId: decoded[i]['userId'],
        timeAdded: decoded[i]['timeAdded'],
        comment: decoded[i]['comment'],
        overallRating: decoded[i]['overallRating'],
        locationRating: decoded[i]['locationRating'],
        custServRating: decoded[i]['serviceRating'],
        amenitiesRating: decoded[i]['amenitiesRating'],
      ));
    }

    return userReviews;
  }

  static Future<ReviewData> getReviewFromPlaceIdAndUserId(String placeId, String userId) async {
    http.Response response = await http.get(
      Uri.parse("$rootUrl/Reviews/$placeId/$userId"),
      headers: {"content-type": "application/json"},
    );

    if (response.body == "") return ReviewData();

    Map<String, dynamic> decoded = jsonDecode(response.body);
    return ReviewData(
      placeId: decoded['placeId'],
      userId: decoded['userId'],
      timeAdded: decoded['timeAdded'],
      comment: decoded['comment'],
      overallRating: decoded['overallRating'],
      locationRating: decoded['locationRating'],
      custServRating: decoded['serviceRating'],
      amenitiesRating: decoded['amenitiesRating'],
    );
  }

  static Future<http.Response?> updateReview(
    String placeId,
    int overallRating,
    int locationRating,
    int amenitiesRating,
    int serviceRating,
    String comment,
  ) async {
    if (currentClient == null) return null;

    Map<String, dynamic> data = {
      "userID": parseJwt(currentClient!.credentials.accessToken)['sub'],
      "placeID": placeId,
      "overallRating": overallRating,
      "locationRating": locationRating,
      "amentitiesRating": amenitiesRating,
      "serviceRating": serviceRating,
      "comment": comment,
    };

    return currentClient!.put(
      Uri.parse("$rootUrl/Reviews/$placeId/${parseJwt(currentClient!.credentials.accessToken)['sub']}"),
      body: jsonEncode(data),
      headers: {"content-type": "application/json"},
    );
  }

  static Future<http.Response?> deleteReview(String placeId) async {
    if (currentClient == null) return null;

    return currentClient!.delete(
      Uri.parse("$rootUrl/Reviews/$placeId/${parseJwt(currentClient!.credentials.accessToken)['sub']}"),
      headers: {"content-type": "application/json"},
    );
  }
}
