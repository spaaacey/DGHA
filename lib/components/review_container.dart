import 'package:dgha/misc/styles.dart';
import 'package:dgha/components/rating_with_title.dart';
import 'package:flutter/material.dart';
import 'package:dgha/models/review.dart';

class ReviewContainer extends StatelessWidget {
  final ReviewData? review;
  const ReviewContainer({this.review, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateAdded = review?.formatDateAdded() ?? DateTime.now();

    return Container(
      child: Column(
        children: <Widget>[
          // ------------------ NOTE: divider
          Container(
            width: double.infinity,
            height: 2,
            color: Styles.midnightBlue,
          ),
          SizedBox(
            height: Styles.spacing / 2,
          ),

          // ------------------ NOTE: Date
          Semantics(
            label: "Date reviewed: ",
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${dateAdded.day}/${dateAdded.month}/${dateAdded.year}",
                style: Styles.pStyle,
              ),
            ),
          ),
          SizedBox(
            height: Styles.spacing / 4,
          ),

          // ------------------ NOTE: Stars
          Semantics(
            label: "Rated: ${review?.overallRating.toString()} out of 5 stars",
            excludeSemantics: true,
            explicitChildNodes: false,
            child: RatingWithTitle(
                title: "Rated: ",
                rating: (review?.overallRating ?? 0).toDouble(),
                isSmall: true,
                spaceBetween: false,
            ),
          ),

          // ------------------ NOTE: Comment
          Semantics(
            label: "Comment: ",
            child: Container(
              width: double.infinity,
              child: SelectableText(
                review?.comment ?? '',
                style: Styles.pStyle,
              ),
            ),
          ),
          SizedBox(
            height: Styles.spacing,
          ),
        ],
      ),
    );
  }
}
