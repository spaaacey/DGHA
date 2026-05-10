import 'package:dgha/misc/data.dart';
import 'package:dgha/models/review.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  static Future<List<ReviewData>> getReviewSetById(String placeId, int setNum) async {
    http.Response res = await http.get(
      Uri.parse('${Data.rootTestingUrl}/Reviews/placeId/$placeId?set=$setNum'),
      headers: {"Accept": "application/json"},
    );

    if (res.statusCode == 200) {
      return ReviewData.decodeReviewListFromJson(res.body);
    } else {
      return <ReviewData>[];
    }
  }
}
