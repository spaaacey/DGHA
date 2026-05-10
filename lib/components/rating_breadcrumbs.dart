import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';

class RatingBreadcrumbs extends StatefulWidget {
  //How many tabs to color in starting at 0
  final int? maxNavPos;
  int? currentNavPos;

  final Color? iconColor;
  final Color? backgroundColor;
  final Color? highlightedIconColor;
  final Color? highlightedBackgroundColor;
  final Function? onTapFirst;
  final Function? onTapSecond;
  final Function? onTapThird;
  final Function? onTapForth;
  final Function? onTapFith;

  RatingBreadcrumbs({
    this.maxNavPos,
    this.currentNavPos,
    this.backgroundColor,
    this.iconColor,
    this.highlightedIconColor,
    this.highlightedBackgroundColor,
    this.onTapFirst,
    this.onTapSecond,
    this.onTapThird,
    this.onTapForth,
    this.onTapFith,
    super.key,
  });
  @override
  _RatingBreadcrumbsState createState() => _RatingBreadcrumbsState();
}

class _RatingBreadcrumbsState extends State<RatingBreadcrumbs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 2, color: Styles.midnightBlue),
          left: BorderSide(width: 2, color: Styles.midnightBlue),
        ),
      ),
      height: 60,
      child: Stack(
        children: <Widget>[
          //----------Line
          Center(
            child: Container(
              height: 3,
              color: Styles.midnightBlue,
            ),
          ),
          //----------Dots
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //----------Overall Rating
                Semantics(
                  label: "Overall Rating",
                  hint: (widget.maxNavPos ?? -1) >= 0
                      ? "Double tap to go to the overall rating page"
                      : "",
                  excludeSemantics: true,
                  child: GestureDetector(
                    child: DghaIcon(
                      padding: 3,
                      paddingPadding: 0,
                      size: 37,
                      backgroundColor: (widget.maxNavPos ?? -1) >= 0
                          ? (widget.highlightedBackgroundColor ?? Styles.midnightBlue)
                          : (widget.backgroundColor ?? Colors.white),
                      icon: Icons.arrow_forward,
                      iconColor: (widget.currentNavPos ?? -1) == 0
                          ? (widget.highlightedIconColor ?? Styles.yellow)
                          : (widget.iconColor ?? Styles.midnightBlue),
                    ),
                    onTap: (widget.maxNavPos ?? -1) >= 0 ? () => widget.onTapFirst?.call() : null,
                  ),
                ),
                //----------Customer Service
                Semantics(
                  label: "Customer Service Rating",
                  hint: (widget.maxNavPos ?? -1) >= 1
                      ? "Double tap to go to the customer service rating page"
                      : "",
                  excludeSemantics: true,
                  child: GestureDetector(
                    child: DghaIcon(
                      padding: 3,
                      paddingPadding: 0,
                      size: 37,
                      backgroundColor: (widget.maxNavPos ?? -1) >= 1
                          ? (widget.highlightedBackgroundColor ?? Styles.midnightBlue)
                          : (widget.backgroundColor ?? Colors.white),
                      icon: Icons.arrow_forward,
                      iconColor: (widget.currentNavPos ?? -1) == 1
                          ? (widget.highlightedIconColor ?? Styles.yellow)
                          : (widget.iconColor ?? Styles.midnightBlue),
                    ),
                    onTap: (widget.maxNavPos ?? -1) >= 1 ? () => widget.onTapSecond?.call() : null,
                  ),
                ),
                //----------Amenities
                Semantics(
                  label: "Amenities Raint",
                  hint: (widget.maxNavPos ?? -1) >= 2
                      ? "Double tap to go to the overall rating page"
                      : "",
                  excludeSemantics: true,
                  child: GestureDetector(
                    child: DghaIcon(
                      padding: 3,
                      paddingPadding: 0,
                      size: 37,
                      backgroundColor: (widget.maxNavPos ?? -1) >= 2
                          ? (widget.highlightedBackgroundColor ?? Styles.midnightBlue)
                          : (widget.backgroundColor ?? Colors.white),
                      icon: Icons.arrow_forward,
                      iconColor: (widget.currentNavPos ?? -1) == 2
                          ? (widget.highlightedIconColor ?? Styles.yellow)
                          : (widget.iconColor ?? Styles.midnightBlue),
                    ),
                    onTap: (widget.maxNavPos ?? -1) >= 2 ? () => widget.onTapThird?.call() : null,
                  ),
                ),
                //----------Location
                Semantics(
                  label: "Location Rating",
                  hint: (widget.maxNavPos ?? -1) >= 3
                      ? "Double tap to go to the location service rating page"
                      : "",
                  excludeSemantics: true,
                  child: GestureDetector(
                    child: DghaIcon(
                      padding: 3,
                      paddingPadding: 0,
                      size: 37,
                      backgroundColor: (widget.maxNavPos ?? -1) >= 3
                          ? (widget.highlightedBackgroundColor ?? Styles.midnightBlue)
                          : (widget.backgroundColor ?? Colors.white),
                      icon: Icons.arrow_forward,
                      iconColor: (widget.currentNavPos ?? -1) == 3
                          ? (widget.highlightedIconColor ?? Styles.yellow)
                          : (widget.iconColor ?? Styles.midnightBlue),
                    ),
                    onTap: (widget.maxNavPos ?? -1) >= 3 ? () => widget.onTapForth?.call() : null,
                  ),
                ),
                //----------Comment
                Semantics(
                  label: "Comment Page",
                  hint: (widget.maxNavPos ?? -1) >= 4
                      ? "Double tap to go to the additonal comment page"
                      : "",
                  excludeSemantics: true,
                  child: GestureDetector(
                    child: DghaIcon(
                      padding: 3,
                      paddingPadding: 0,
                      size: 37,
                      backgroundColor: (widget.maxNavPos ?? -1) >= 4
                          ? (widget.highlightedBackgroundColor ?? Styles.midnightBlue)
                          : (widget.backgroundColor ?? Colors.white),
                      icon: Icons.arrow_forward,
                      iconColor: (widget.currentNavPos ?? -1) == 4
                          ? (widget.highlightedIconColor ?? Styles.yellow)
                          : (widget.iconColor ?? Styles.midnightBlue),
                    ),
                    onTap: (widget.maxNavPos ?? -1) >= 4 ? () => widget.onTapFith?.call() : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
