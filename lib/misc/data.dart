import 'package:dgha/models/languages.dart';
import 'package:dgha/models/info_menu_card_data.dart';
import 'package:dgha/models/menu_tile_data.dart';
import 'package:dgha/models/page_nav.dart';
import 'package:dgha/screens/info_screen.dart';
import 'package:dgha/screens/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Data {
  // -------------------------------------- URL
  static final String rootUrl = "https://dgha-api.azurewebsites.net";
  static final String rootTestingUrl = "https://dgha-api-testing.azurewebsites.net"; 

  // -------------------------------------- NAVIGATION
  static List<PageNav> pages = <PageNav>[];
  // -------------------------------------- CARD DATA
  // ------------- GENERAL INFO CARDS
  static final List<InfoMenuCardData> generalInfoCardData = [guideDogCardData, accessCardData];
  static final InfoMenuCardData guideDogCardData = new InfoMenuCardData(
      cardTitle: "Guide Dogs",
      pageToNavigateTo: InfoScreen.id,
      texts: infoLang,
      imagePath: "assets/images/menu_card/info.png",
      pageTitle: "Guide Dogs",
      semanticLabel: "Guide Dogs",
      semanticHint: "Double tap to read more about Guide Dogs");

  static final InfoMenuCardData accessCardData = new InfoMenuCardData(
      cardTitle: "Access",
      pageToNavigateTo: InfoScreen.id,
      texts: accessLang,
      imagePath: "assets/images/menu_card/access.png",
      pageTitle: "Access",
      semanticLabel: "Access",
      semanticHint: "Double Tap to read more about Guide Dogs Access");

  // -------------- LAWS INFO CARDS
  static final List<InfoMenuCardData> lawInfoCardDataABC = [
    actCardData,
    fedCardData,
    nswCardData,
    ntCardData,
    qldCardData,
    saCardData,
    tasCardData,
    vicCardData,
    waCardLaw,
  ];

  static final InfoMenuCardData fedCardData = new InfoMenuCardData(
      cardTitle: "Federal",
      pageToNavigateTo: InfoScreen.id,
      texts: fedLang,
      imagePath: "assets/images/menu_card/federal.png",
      pageTitle: "Federal",
      semanticLabel: "Federal",
      semanticHint: "Double Tap to read more about Federal Law regarding Guide Dogs");

  static final InfoMenuCardData actCardData = new InfoMenuCardData(
      cardTitle: "ACT",
      pageToNavigateTo: InfoScreen.id,
      texts: actLang,
      imagePath: "assets/images/menu_card/act.png",
      pageTitle: "ACT",
      semanticLabel: "Australian Capital Territory",
      semanticHint: "Double Tap to read more about Australian Capital Territory Law regarding Guide Dogs");

  static final InfoMenuCardData nswCardData = new InfoMenuCardData(
      cardTitle: "NSW",
      pageToNavigateTo: InfoScreen.id,
      texts: nswLang,
      imagePath: "assets/images/menu_card/nsw.png",
      pageTitle: "NSW Law",
      semanticLabel: "New South Wales",
      semanticHint: "Double Tap to read more about New South Wales Law regarding Guide Dogs");

  static final InfoMenuCardData ntCardData = new InfoMenuCardData(
      cardTitle: "NT",
      pageToNavigateTo: InfoScreen.id,
      texts: ntLang,
      imagePath: "assets/images/menu_card/nt.png",
      pageTitle: "NT Law",
      semanticLabel: "Northern Territory",
      semanticHint: "Double Tap to read more about Northern Territory Law regarding Guide Dogs");

  static final InfoMenuCardData qldCardData = new InfoMenuCardData(
      cardTitle: "QLD",
      pageToNavigateTo: InfoScreen.id,
      texts: qldLang,
      imagePath: "assets/images/menu_card/qld.png",
      pageTitle: "QLD Law",
      semanticLabel: "Queensland",
      semanticHint: "Double Tap to read more about Queensland Law regarding Guide Dogs");

  static final InfoMenuCardData saCardData = new InfoMenuCardData(
      cardTitle: "SA",
      pageToNavigateTo: InfoScreen.id,
      texts: saLang,
      imagePath: "assets/images/menu_card/sa.png",
      pageTitle: "SA Law",
      semanticLabel: "South Australia",
      semanticHint: "Double Tap to read more about South Australian Law regarding Guide Dogs");

  static final InfoMenuCardData tasCardData = new InfoMenuCardData(
      cardTitle: "TAS",
      pageToNavigateTo: InfoScreen.id,
      texts: tasLang,
      imagePath: "assets/images/menu_card/tas.png",
      pageTitle: "TAS Law",
      semanticLabel: "Tasmania",
      semanticHint: "Double Tap to read more about Tasmanian Law regarding Guide Dogs");

  static final InfoMenuCardData vicCardData = new InfoMenuCardData(
      cardTitle: "VIC",
      pageToNavigateTo: InfoScreen.id,
      texts: vicLang,
      imagePath: "assets/images/menu_card/vic.png",
      pageTitle: "VIC Law",
      semanticLabel: "Victoria",
      semanticHint: "Double Tap to read more about Victorian Law regarding Guide Dogs");

  static final InfoMenuCardData waCardLaw = new InfoMenuCardData(
      cardTitle: "WA",
      pageToNavigateTo: InfoScreen.id,
      texts: waLang,
      imagePath: "assets/images/menu_card/wa.png",
      pageTitle: "WA Law",
      semanticLabel: "Western Australia",
      semanticHint: "Double Tap to read more about Western Australian Law regarding Guide Dogs");

  // ------------------------------------ MENU LIST TILES
  // ---------------- GENERAL INFO TILES
  static final MenuTileData guideDogInfoTileData = new MenuTileData(
      title: "Guide Dogs", pageToNavigateTo: InfoScreen.id, texts: infoLang, icon: FontAwesomeIcons.paw, semanticLabel: "Guide Dogs", semanticHint: "Double tap to read more about Guide Dogs");

  static final MenuTileData guideDogAccessTileData = new MenuTileData(
      title: "Access", pageToNavigateTo: InfoScreen.id, texts: accessLang, icon: FontAwesomeIcons.unlockKeyhole, semanticLabel: "Access", semanticHint: "Double tap to read more about Guide Dogs Access");

  // ---------------- LAW TILES
  static final MenuTileData lawsTilesListData = new MenuTileData(
      title: "Laws",
      pageToNavigateTo: InfoScreen.id,
      texts: fedLang,
      icon: FontAwesomeIcons.gavel,
      children: lawsTileData,
      semanticLabel: "Laws Drop Down",
      semanticHint: "Double tap to open Laws Menu");

  static final List<MenuTileData> lawsTileData = <MenuTileData>[fedTileData, actTileData, nswTileData, ntTileData, qldTileData, saTileData, tasTileData, vicTileData, waTileData];

  static final MenuTileData fedTileData = new MenuTileData(
      title: "Federal Law", pageToNavigateTo: InfoScreen.id, texts: fedLang, semanticLabel: "Federal Law", semanticHint: "Double Tap to read more about Federal Law regarding Guide Dogs");

  static final MenuTileData actTileData = new MenuTileData(
      title: "ACT Law",
      pageToNavigateTo: InfoScreen.id,
      texts: actLang,
      semanticLabel: "Australian Capital Territory Law",
      semanticHint: "Double Tap to read more about Australian Capital Territory Law regarding Guide Dogs");

  static final MenuTileData nswTileData = new MenuTileData(
      title: "NSW Law", pageToNavigateTo: InfoScreen.id, texts: nswLang, semanticLabel: "New South Wales Law", semanticHint: "Double Tap to read more about New South Wales Law regarding Guide Dogs");

  static final MenuTileData ntTileData = new MenuTileData(
      title: "NT Law",
      pageToNavigateTo: InfoScreen.id,
      texts: ntLang,
      semanticLabel: "Northern Territory Law",
      semanticHint: "Double Tap to read more about Northern Territory Law regarding Guide Dogs");

  static final MenuTileData qldTileData = new MenuTileData(
      title: "QLD Law", pageToNavigateTo: InfoScreen.id, texts: qldLang, semanticLabel: "Queensland Law", semanticHint: "Double Tap to read more about Queensland Law regarding Guide Dogs");

  static final MenuTileData saTileData = new MenuTileData(
      title: "SA Law", pageToNavigateTo: InfoScreen.id, texts: saLang, semanticLabel: "South Australian Law", semanticHint: "Double Tap to read more about South Australian Law regarding Guide Dogs");

  static final MenuTileData tasTileData = new MenuTileData(
      title: "TAS Law", pageToNavigateTo: InfoScreen.id, texts: tasLang, semanticLabel: "Tasmanian Law", semanticHint: "Double Tap to read more about Tasmanian Law regarding Guide Dogs");

  static final MenuTileData vicTileData = new MenuTileData(
      title: "VIC Law", pageToNavigateTo: InfoScreen.id, texts: vicLang, semanticLabel: "Victorian Law", semanticHint: "Double Tap to read more about Victorian Law regarding Guide Dogs");

  static final MenuTileData waTileData = new MenuTileData(
      title: "WA Law",
      pageToNavigateTo: InfoScreen.id,
      texts: waLang,
      semanticLabel: "Western Australia Law",
      semanticHint: "Double Tap to read more about Western Australian Law regarding Guide Dogs");

  static final MenuTileData membershipTitleData = new MenuTileData(
      title: "Membership",
      icon: FontAwesomeIcons.solidUser,
      link: "http://dgha.org.au/dgha/membership/",
      semanticLabel: "Membership",
      semanticHint: "Double tap to go to the Guide Dog Handlder Australia Membership page");

  static final MenuTileData donateTileData = new MenuTileData(
      title: "Donation",
      icon: FontAwesomeIcons.handHoldingDollar,
      link: "http://dgha.org.au/dgha/membership/",
      semanticLabel: "Donation",
      semanticHint: "Double tap to go to the Guide Dog Handler Australia Donation page");

  static final MenuTileData login =
      new MenuTileData(title: "Login", pageToNavigateTo: LoginScreen.id, icon: FontAwesomeIcons.rightToBracket, semanticLabel: "Login", semanticHint: "Double tap to go to the Login/Register page");

  // ---------------------------------------- LANGUAGES
  // ---------------------- GENERAL INFO LANGUAGES
  static final List<Language> infoLang = <Language>[
    Language(languageName: "English", path: "assets/languages/guide_dog_info/english.md"),
    Language(languageName: "Japanese", path: "assets/languages/guide_dog_info/japanese.md"),
    Language(languageName: "Korean", path: "assets/languages/guide_dog_info/korean.md"),
    Language(languageName: "Thai", path: "assets/languages/guide_dog_info/thai.md"),
  ];

  static final List<Language> accessLang = <Language>[
    Language(languageName: "English", path: "assets/languages/guide_dog_access/english.md"),
    Language(languageName: "Japanese", path: "assets/languages/guide_dog_access/japanese.md"),
    Language(languageName: "Korean", path: "assets/languages/guide_dog_access/korean.md"),
    Language(languageName: "Thai", path: "assets/languages/guide_dog_access/thai.md"),
  ];

  // ----------------------- LAWS INFO LANGUAGES
  static final List<Language> fedLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/federal/english.md"),
    Language(languageName: "Japanese", path: "assets/languages/laws/federal/japanese.md"),
    Language(languageName: "Korean", path: "assets/languages/laws/federal/korean.md"),
    Language(languageName: "Thai", path: "assets/languages/laws/federal/thai.md"),
  ];

  static final List<Language> actLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/act/english.md"),
    Language(languageName: "Japanese", path: "assets/languages/laws/act/japanese.md"),
    Language(languageName: "Korean", path: "assets/languages/laws/act/korean.md"),
    Language(languageName: "Thai", path: "assets/languages/laws/act/thai.md"),
  ];

  static final List<Language> nswLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/nsw/english.md"),
    Language(languageName: "Japanese", path: "assets/languages/laws/nsw/japanese.md"),
    Language(languageName: "Korean", path: "assets/languages/laws/nsw/korean.md"),
    Language(languageName: "Thai", path: "assets/languages/laws/nsw/thai.md"),
  ];

  static final List<Language> ntLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/nt/english.md"),
    Language(languageName: "Japanese", path: "assets/languages/laws/nt/japanese.md"),
    Language(languageName: "Korean", path: "assets/languages/laws/nt/korean.md"),
    Language(languageName: "Thai", path: "assets/languages/laws/nt/thai.md"),
  ];

  static final List<Language> qldLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/qld/english.md"),
    Language(languageName: "Japanese", path: "assets/languages/laws/qld/japanese.md"),
    Language(languageName: "Korean", path: "assets/languages/laws/qld/korean.md"),
    Language(languageName: "Thai", path: "assets/languages/laws/qld/thai.md"),
  ];

  static final List<Language> saLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/sa/english.md"),
    Language(languageName: "Japanese", path: "assets/languages/laws/sa/japanese.md"),
    Language(languageName: "Korean", path: "assets/languages/laws/sa/korean.md"),
    Language(languageName: "Thai", path: "assets/languages/laws/sa/thai.md"),
  ];

  static final List<Language> tasLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/tas/english.md"),
    Language(languageName: "Japanese", path: "assets/languages/laws/tas/japanese.md"),
    Language(languageName: "Korean", path: "assets/languages/laws/tas/korean.md"),
    Language(languageName: "Thai", path: "assets/languages/laws/tas/thai.md"),
  ];

  static final List<Language> vicLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/vic/english.md"),
    Language(languageName: "Japanese", path: "assets/languages/laws/vic/japanese.md"),
    Language(languageName: "Korean", path: "assets/languages/laws/vic/korean.md"),
    Language(languageName: "Thai", path: "assets/languages/laws/vic/thai.md"),
  ];

  static final List<Language> waLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/wa/english.md"),
    Language(languageName: "Japanese", path: "assets/languages/laws/wa/japanese.md"),
    Language(languageName: "Korean", path: "assets/languages/laws/wa/korean.md"),
    Language(languageName: "Thai", path: "assets/languages/laws/wa/thai.md"),
  ];

  static final List<String> allPlaceTypes = <String>[
    "accounting",
    "airport",
    "amusement_park",
    "aquarium",
    "art_gallery",
    "atm",
    "bakery",
    "bank",
    "bar",
    "beauty_salon",
    "bicycle_store",
    "book_store",
    "bowling_alley",
    "bus_station",
    "cafe",
    "campground",
    "car_dealer",
    "car_rental",
    "car_repair"
    "car_wash",
    "casino",
    "cemetery",
    "church",
    "city_hall",
    "clothing_store",
    "convenience_store",
    "courthouse",
    "dentist",
    "department_store",
    "doctor",
    "drugstore",
    "electrician",
    "electronics_store",
    "embassy",
    "fire_station",
    "florist",
    "funeral_home",
    "furniture_store",
    "gas_station",
    "grocery_or_supermarket",
    "gym",
    "hair_care",
    "hardware_store",
    "hindu_temple",
    "home_goods_store",
    "hospital",
    "insurance_agency",
    "jewelry_store",
    "laundry",
    "lawyer",
    "library",
    "light_rail_station",
    "liquor_store",
    "local_government_office",
    "locksmith",
    "lodging",
    "meal_delivery",
    "meal_takeaway",
    "mosque",
    "movie_rental",
    "movie_theater",
    "moving_company",
    "museum",
    "night_club",
    "painter",
    "park",
    "parking",
    "pet_store",
    "pharmacy",
    "physiotherapist",
    "plumber",
    "police",
    "post_office",
    "primary_school",
    "real_estate_agency",
    "restaurant",
    "roofing_contractor",
    "rv_park",
    'school',
    "secondary_school",
    "shoe_store",
    "shopping_mall",
    "spa",
    "stadium",
    "storage",
    "store",
    "subway_station",
    "supermarket",
    "synagogue",
    "taxi_stand",
    "tourist_attraction",
    "train_station",
    "transit_station",
    "travel_agency",
    "university",
    "veterinary_care",
    "zoo",
  ];
}
