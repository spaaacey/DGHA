import 'package:dgha/components/menu_expansion_tile.dart';
import 'package:dgha/components/menu_tile.dart';
import 'package:dgha/misc/data.dart';
import 'package:dgha/misc/dgha_api.dart';
import 'package:dgha/misc/styles.dart';
import 'package:dgha/models/menu_tile_data.dart';
import 'package:dgha/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuDrawer extends StatefulWidget {
  final double? width;

  MenuDrawer({this.width});

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  double width = 0;
  bool widthIsSet = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      if (DghaApi.currentClient != null) {
        setState(() {
          isLoggedIn = true;
        });
        print("huh");
      }
    } catch (e) {
      print(e);
    }
  }

  double setWidth() {
    if (widthIsSet == false) {
      width = MediaQuery.of(context).size.width * 0.75;
    }
    return width;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Styles.normalRadius),
          bottomRight: Radius.circular(Styles.normalRadius),
        ),
        child: Container(
          width: setWidth(),
          constraints: BoxConstraints(
            minWidth: 300,
            maxWidth: 500,
          ),
          child: Drawer(
            elevation: 20,
            semanticLabel: "Side bar menu",
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: Styles.appBarHorizontalPadding),
              children: <Widget>[
                SizedBox(
                  height: Styles.iconSize / 3,
                ),
                MenuTile(tile: Data.guideDogInfoTileData),
                MenuTile(tile: Data.guideDogAccessTileData),
                MenuExpansionTile(tile: Data.lawsTilesListData),
                MenuTile(tile: Data.membershipTitleData),
                MenuTile(tile: Data.donateTileData),
                MenuTile(
                  tile: new MenuTileData(
                    title: isLoggedIn ? "Sign out" : "Sign in",
                    icon: isLoggedIn
                        ? FontAwesomeIcons.rightFromBracket
                        : FontAwesomeIcons.rightToBracket,
                    semanticLabel: isLoggedIn ? "Log out" : "Login",
                    semanticHint: isLoggedIn
                        ? "Double tap to sign out"
                        : "Double tap to go to the sign in page",
                    pageToNavigateTo: LoginScreen.id,
                    onTap: () {
                      if (isLoggedIn) {
                        DghaApi.signOut();
                        Navigator.of(context).popAndPushNamed(LoginScreen.id);
                      } else {
                        Navigator.of(context).popAndPushNamed(LoginScreen.id);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
