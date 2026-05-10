import 'package:dgha/misc/styles.dart';
import 'package:dgha/models/info_menu_card_data.dart';
import 'package:dgha/models/screen_args.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final double? cardWidth;
  final double? cardHeight;
  final InfoMenuCardData? card;
  final int? cardIndex;
  final int? listLength;

  const InfoCard({this.cardWidth, this.cardHeight, this.card, this.cardIndex, this.listLength, super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      value: "Card $cardIndex of $listLength",
      label: card?.semanticLabel,
      hint: card?.semanticHint,
      excludeSemantics: true,
      explicitChildNodes: false,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            card?.pageToNavigateTo ?? '',
            arguments: InfoScrArgs(title: card?.pageTitle, texts: card?.texts),
          );
        },
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            color: Styles.midnightBlue,
            borderRadius: const BorderRadius.all(Radius.circular(Styles.normalRadius)),
            boxShadow: const [
              BoxShadow(
                color: Styles.grey,
                blurRadius: 3,
                offset: Offset(2, 3),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: Styles.imageMargin),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(card?.imagePath ?? '')),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(Styles.textPadding),
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Styles.normalRadius),
                    bottomRight: Radius.circular(Styles.normalRadius),
                  ),
                ),
                child: Text(
                  card?.cardTitle ?? '',
                  style: Styles.h3Style,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
