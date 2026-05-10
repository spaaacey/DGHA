import 'package:dgha/components/appbar.dart';
import 'package:dgha/components/bottom_navigation.dart';
import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/components/loading_text.dart';
import 'package:dgha/components/place_card.dart';
import 'package:dgha/components/menu_drawer.dart';
import 'package:dgha/misc/data.dart';
import 'package:dgha/misc/styles.dart';
import 'package:dgha/models/page_nav.dart';
import 'package:dgha/models/place.dart';
import 'package:dgha/screens/search_screen.dart';
import 'package:dgha/services/open_dynamic_link.dart';
import 'package:dgha/services/place_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExploreScreen extends StatefulWidget {
  static const String id = "Explore Screen";
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // ------------------------- NOTE: Variables
  List<PlaceData> placeList = <PlaceData>[];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;

  // -------------- NOTE: Dimensions
  double scrWidth = 0;
  double scrHeight = 0;
  double drawerWidth = 0;

  // ------------------------- NOTE: Init
  @override
  void initState() {
    super.initState();
    Data.pages.add(PageNav.exploreMenuScr);
    OpenDynamicLink.initDynamicLink(context);
    getRecommendedPlaces();
  }

  // ------------------------- NOTE: Get Recommended
  void getRecommendedPlaces() async {
    setState(() {
      this.isLoading = true;
    });

    List<PlaceData> _placeList = await PlaceService.getRecommendedPlaces();

    try {
      setState(() {
        this.placeList = _placeList;
        this.isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  // ------------------------- NOTE: Disposed
  @override
  void dispose() {
    super.dispose();
    if (Data.pages.last == PageNav.exploreMenuScr) {
      Data.pages.removeLast();
    }
  }

  void calcDimensions(Orientation orientation) {
    this.scrWidth = MediaQuery.of(context).size.width;
    this.scrHeight = MediaQuery.of(context).size.height;

    if (orientation == Orientation.portrait) {
      this.drawerWidth = this.scrWidth * 0.75;
    } else {
      this.drawerWidth = this.scrHeight * 0.75;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.softGrey,
      key: _scaffoldKey,
      drawer: MenuDrawer(
        width: this.drawerWidth,
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            // ------------------------- NOTE: Calc Dimensions
            calcDimensions(orientation);

            return Stack(
              children: <Widget>[
                // --------------------- NOTE: Body
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Styles.spacing),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      SizedBox(height: Styles.heightFromAppBar),

                      // --------- NOTE: Loading Text
                      LoadingText(condition: this.isLoading),
                      // --------- NOTE: Place Cards
                      Column(
                          children: this
                              .placeList
                              .map((place) => PlaceCard(
                                    placeData: place,
                                  ))
                              .toList()),

                      SizedBox(height: Styles.spacing)
                    ],
                  ),
                ),

                // --------------------- NOTE: App Bar
                DghaAppBar(
                  text: "Explore",
                  isMenu: true,
                  semanticLabel: "Explore Page",
                  childOne: Semantics(
                    button: true,
                    label: "Menu",
                    hint: "Double tap to open side bar menu",
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState?.openDrawer();
                        });
                      },
                      child: DghaIcon(
                        icon: FontAwesomeIcons.bars,
                        backgroundColor: Styles.midnightBlue,
                        iconColor: Styles.yellow,
                      ),
                    ),
                  ),
                  childTwo: Semantics(
                    button: true,
                    label: "Search",
                    hint: "Double tap to open search",
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SearchScreen.id);
                      },
                      child: DghaIcon(
                        icon: FontAwesomeIcons.magnifyingGlass,
                        backgroundColor: Styles.midnightBlue,
                        iconColor: Styles.yellow,
                      ),
                    ),
                  ),
                ),

                // --------------------- NOTE: Loading Screen
                
              ],
            );
          },
        ),
      ),

      // ------------------------------ NOTE: Bottom navigation
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.ratingsPage),
    );
  }
}
