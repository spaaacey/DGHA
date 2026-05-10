import 'package:dgha/models/languages.dart';

class InfoMenuCardData {
  final String? cardTitle;
  final String? pageToNavigateTo;
  final List<Language>? texts;
  final String? pageTitle;
  final String? imagePath;
  final String? semanticLabel;
  final String? semanticHint;

  InfoMenuCardData({this.cardTitle, this.pageToNavigateTo, this.texts, this.imagePath, this.pageTitle, this.semanticLabel, this.semanticHint});
}
