import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectableContainer extends StatelessWidget {
  final List<String>? text;

  const SelectableContainer({this.text, super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Could not launch $url";
    }
  }

  List<Widget> lines() {
    List<Widget> widgets = <Widget>[];
    final lines = text ?? [];

    for (int i = 0; i < lines.length; i++) {
      List<String> words = lines[i].split(" ");
      String newLine = lines[i];
      TextStyle textStyle = Styles.pStyle;

      bool isBulletPoint = false;

      // H TAGS
      if (words[0] == "##") {
        newLine = newLine.replaceFirst(new RegExp(r'## '), '');
        textStyle = Styles.h2Style;
      } else if (words[0] == "###") {
        newLine = newLine.replaceFirst(new RegExp(r'### '), '');
        textStyle = Styles.h3Style;
      } else if (words[0] == "####") {
        newLine = newLine.replaceFirst(new RegExp(r'#### '), '');
        textStyle = Styles.h4Style;
      } else if (words[0] == "-" || words[0] == "*") {
        newLine = newLine.replaceFirst(new RegExp(r'- '), '');
        newLine = newLine.replaceFirst(new RegExp(r"\*   "), '');
        isBulletPoint = true;
      }

      if (newLine.contains("https://www.")) {
        String frontString = "";
        String endString = "";
        String linkText = "";
        String url = "";

        int indexOfOpenSquareBracket;
        int indexOfClosedSquareBracket;
        int indexOfOpenBracket;
        int indexOfClosedBracket;

        indexOfOpenSquareBracket = newLine.indexOf("[");
        indexOfClosedSquareBracket = newLine.indexOf("]");
        indexOfOpenBracket = newLine.indexOf("(");
        indexOfClosedBracket = newLine.indexOf(")");

        frontString = newLine.substring(0, indexOfOpenSquareBracket);

        if (indexOfClosedBracket < newLine.length - 1) {
          endString = newLine.substring(indexOfClosedBracket + 1, newLine.length - 1);
        }

        linkText = newLine.substring(indexOfOpenSquareBracket + 1, indexOfClosedSquareBracket);
        url = newLine.substring(indexOfOpenBracket + 1, indexOfClosedBracket);

        Widget link = Wrap(
          children: <Widget>[
            SelectableText(
              frontString + ": ",
              style: Styles.pStyle,
            ),
            GestureDetector(
              onTap: () {
                _launchURL(url); 
              },
              child: Text(
                linkText,
                style: Styles.linkStyle,
              ),
            ),
            // SelectableText(endString, style: Styles.pStyle,)
          ],
        );

        widgets.add(link);
      } else if (isBulletPoint) {
        Container bullet = Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SelectableText(
                "\u2022  ",
                style: textStyle,
              ),
              Expanded(
                child: SelectableText(
                  newLine,
                  style: textStyle,
                ),
              )
            ],
          ),
        );
        widgets.add(bullet);
      } else {
        SelectableText ts = SelectableText(
          newLine,
          style: textStyle,
        );
        widgets.add(ts);
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(Styles.spacing, 20, Styles.spacing, Styles.spacing * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines(),
      ),
    );
  }
}
