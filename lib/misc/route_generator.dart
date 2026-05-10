import 'package:dgha/models/screen_args.dart';
import 'package:dgha/screens/info_screen.dart';
import 'package:dgha/screens/login_screen.dart';
import 'package:dgha/screens/info_menu_screen.dart';
import 'package:dgha/screens/explore_screen.dart';
import 'package:dgha/screens/report_screen.dart';
import 'package:dgha/screens/search_screen.dart';
import 'package:dgha/screens/user_rating_screen.dart';
import 'package:dgha/screens/register_screen.dart';
import 'package:dgha/screens/place_details_screen.dart';
import 'package:dgha/models/place.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case LoginScreen.id_user_rating:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(
                  goToReviewScreen: true,
                  placeData: settings.arguments as PlaceData?,
                ));
      case LoginScreen.id_report:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(
                  goToReportScreen: true,
                  placeData: settings.arguments as PlaceData?,
                ));
      case InfoScreen.id:
        InfoScrArgs? infoScrArgs;
        try {
          infoScrArgs = settings.arguments as InfoScrArgs;
        } catch (e) {}
        return MaterialPageRoute(
            builder: (_) => InfoScreen(
                  appBarTitle: infoScrArgs?.title,
                  texts: infoScrArgs?.texts,
                ));
      case InfoMenuScreen.id:
        return MaterialPageRoute(builder: (_) => InfoMenuScreen());
      case ExploreScreen.id:
        return MaterialPageRoute(builder: (_) => ExploreScreen());
      case PlaceDetailsScreen.id:
        return MaterialPageRoute(builder: (_) => PlaceDetailsScreen(settings.arguments as PlaceData));
      case UserRatingScreen.id:
        return MaterialPageRoute(builder: (_) => UserRatingScreen(settings.arguments as PlaceData));
      case RegisterScreen.id:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case ReportScreen.id:
        return MaterialPageRoute(builder: (_) => ReportScreen(settings.arguments as PlaceData));
      case SearchScreen.id:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      default:
        return MaterialPageRoute(builder: (_) => InfoMenuScreen());
    }
  }
}
