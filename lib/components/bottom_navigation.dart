import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/misc/data.dart';
import 'package:dgha/misc/styles.dart';
import 'package:dgha/models/page_nav.dart';
import 'package:dgha/screens/explore_screen.dart';
import 'package:dgha/screens/info_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ActivePageEnum {
  ratingsPage,
  infoPage,
}

class DGHABotNav extends StatelessWidget {
  final ActivePageEnum? activeTab;

  const DGHABotNav({this.activeTab, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Styles.normalRadius),
          topRight: Radius.circular(Styles.normalRadius),
        ),
        boxShadow: [BoxShadow(color: Styles.grey, blurRadius: 3, offset: Offset(0, -3))],
      ),
      child: Stack(
        children: <Widget>[
          DghaIcon(
            icon: FontAwesomeIcons.bars,
            backgroundColor: Colors.transparent,
            iconColor: Colors.transparent,
          ),
          Row(
            // -------------------- Rating Button
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: this.activeTab == ActivePageEnum.ratingsPage ? Styles.yellow : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Styles.normalRadius),
                    ),
                  ),
                  child: Semantics(
                    label: "Rating Page",
                    hint: "Double tap to go to the rating page",
                    excludeSemantics: true,
                    child: MaterialButton(
                      child: DghaIcon(
                        icon: FontAwesomeIcons.solidStar,
                        iconColor: Styles.midnightBlue,
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        if (Data.pages.last != PageNav.exploreMenuScr) {
                          Navigator.pushNamed(context, ExploreScreen.id);
                          // Navigator.pushNamedAndRemoveUntil(context, ExploreScreen.id, ModalRoute.withName(ExploreScreen.id));
                        }
                      },
                    ),
                  ),
                ),
              ),
              // -------------------- Middle Line
              Container(
                width: 2.0,
                color: Styles.midnightBlue,
                height: 35,
              ),
              // -------------------- Dog Info Button
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: this.activeTab == ActivePageEnum.infoPage ? Styles.yellow : Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Styles.normalRadius),
                    ),
                  ),
                  child: Semantics(
                    label: "Information Page",
                    hint: "Double tap to go to the information page",
                    excludeSemantics: true,
                    child: MaterialButton(
                      child: DghaIcon(
                        icon: FontAwesomeIcons.dog,
                        iconColor: Styles.midnightBlue,
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        if (Data.pages.last != PageNav.infoMenuScr) {
                          Navigator.pushNamed(context, InfoMenuScreen.id);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
