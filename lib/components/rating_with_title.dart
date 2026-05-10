//The widget to display the average ratings on the page
import 'package:dgha/components/dgha_star_rating.dart';
import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';

class RatingWithTitle extends StatelessWidget {
  final String? title;
  final double? rating;
  final bool isSmall;
  final bool spaceBetween;

  const RatingWithTitle({this.title, this.rating, this.isSmall = false, this.spaceBetween = true, super.key});

  @override
  Widget build(BuildContext context) {
    double scale = MediaQuery.of(context).textScaler.scale(1);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        alignment: spaceBetween ? WrapAlignment.spaceBetween : WrapAlignment.start,
        children: <Widget>[
          //----------Title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Text(
              title ?? '',
              style: Styles.h4Style,
            ),
          ),
          
          DghaStarRating(
            changeRatingOnTap: false,
            rating: rating ?? 0,
            height: isSmall ? 26 * scale : 30 * scale,
          ),
        ],
      ),
    );
  }
}
