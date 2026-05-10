import 'package:dgha/components/dgha_star_rating.dart';
import 'package:dgha/components/review_count_container.dart';
import 'package:dgha/misc/styles.dart';
import 'package:dgha/screens/place_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:dgha/models/place.dart';

class PlaceCard extends StatelessWidget {
  final PlaceData placeData;

  const PlaceCard({required this.placeData, super.key});

  @override
  Widget build(BuildContext context) {
    
    String name = placeData.name ?? '';
    String rating = (placeData.avgOverallRating ?? 0).toStringAsPrecision(2);
    String reviews = (placeData.numOfAllReviews ?? 0).toString();
    String type = (placeData.types?.isNotEmpty ?? false) ? placeData.types![0] : '';
    String address = placeData.address ?? '';

    return GestureDetector(
      child: Semantics(
        label: "$name, $rating stars, $reviews reviews, place type: $type, address: $address",
        hint: "Double tap to view more details",
        excludeSemantics: true,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(Styles.normalRadius)),
            boxShadow: [
              BoxShadow(
                color: Styles.grey,
                blurRadius: 6,
                offset: Offset(1, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Builder(
                builder: (context) {
                  return (placeData.numOfAllReviews ?? 0) > 0
                      ? stars()
                      : noRating();
                },
              ),
              Text(
                placeData.name ?? '',
                style: Styles.h3Style,
              ),
              Text(
                placeData.address ?? '',
                style: Styles.pStyle,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, PlaceDetailsScreen.id,
            arguments: placeData);
      },
    );
  }

  Widget stars() {
    return Row(
      children: <Widget>[
        IgnorePointer(
          child: DghaStarRating(
            height: 30,
            rating: placeData.avgOverallRating ?? 0,
            starCount: 5,
          ),
        ),
        SizedBox(
          width: Styles.spacing * 0.25,
        ),
        YellowTagHighlight(
            text: (placeData.numOfAllReviews ?? 0).toString(),
            textStyle: Styles.boldPStyle)
      ],
    );
  }

  Widget noRating() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Styles.yellow,
          borderRadius: BorderRadius.all(
            Radius.circular(Styles.normalRadius),
          )),
      child: Text(
        "No Reviews",
        style: Styles.boldPStyle,
      ),
    );
  }
}
