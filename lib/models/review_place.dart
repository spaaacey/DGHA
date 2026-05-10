import 'package:dgha/models/review.dart';

class ReviewPlace {
  final double averageRating;
  final double averageLocationRating;
  final double averageAmenitiesRating;
  final double averageServiceRating;
  final int count;
  final List<ReviewData> reviews;

  ReviewPlace({
    this.averageRating = 0,
    this.averageLocationRating = 0,
    this.averageAmenitiesRating = 0,
    this.averageServiceRating = 0,
    this.count = 0,
    this.reviews = const <ReviewData>[],
  });
}
