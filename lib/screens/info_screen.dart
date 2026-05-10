import 'package:dgha/components/appbar.dart';
import 'package:dgha/components/bottom_navigation.dart';
import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/components/menu_drawer.dart';
import 'package:dgha/components/selectable_contrainer.dart';
import 'package:dgha/misc/data.dart';
import 'package:dgha/misc/helper.dart';
import 'package:dgha/misc/styles.dart';
import 'package:dgha/models/languages.dart';
import 'package:dgha/models/page_nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoScreen extends StatefulWidget {
  static const String id = "Info Screen";
  final String? appBarTitle;
  final List<Language>? texts;

  const InfoScreen({this.appBarTitle, this.texts, super.key});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  // used for closing or opening drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String infoText = "";
  String languageName = "";
  double scrHeight = 0;
  double scrWidth = 0;
  double textScale = 1;
  double popUpHeight = 50;
  final double popUpTextHeight = 50;
  final double popUpMaxHeight = 90;

  // drawer properties
  double drawerWidth = 0;

  List<String> spans = <String>[];

  // NOTE: init
  @override
  void initState() {
    super.initState();
    loadText(0);
    Data.pages.add(PageNav.infoScr);
  }

  void calcDimensions(Orientation orientation) {
    this.scrWidth = MediaQuery.of(context).size.width;
    this.scrHeight = MediaQuery.of(context).size.height;
    this.textScale = MediaQuery.of(context).textScaler.scale(1);

    if (this.textScale < 1.5 || this.textScale == 1.5) {
      this.popUpHeight = this.popUpTextHeight;
    } else if (this.textScale > 1.5 && this.textScale < 2) {
      this.popUpHeight = this.popUpTextHeight * this.textScale * 0.8;
    } else if (this.textScale > 2 || this.textScale == 2) {
      this.popUpHeight = this.popUpTextHeight * this.textScale * 0.7;
    }

    this.popUpHeight = this.popUpHeight > this.popUpMaxHeight ? this.popUpMaxHeight : this.popUpHeight;
    this.drawerWidth = orientation == Orientation.portrait ? this.scrWidth * 0.75 : this.scrHeight * 0.75;
  }

  void loadText(int index) {
    final texts = widget.texts;
    if (texts == null || index >= texts.length) return;
    Helper().loadMd(context, texts[index].path).then((data) {
      setState(() {
        this.spans = data;
        languageName = texts[index].languageName ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuDrawer(
        width: this.drawerWidth,
      ),
      body: SafeArea(child: OrientationBuilder(
        builder: (context, orientation) {
          calcDimensions(orientation);
          return Stack(
            children: <Widget>[
              Container(
                height: this.scrHeight,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),

                    // ------------ TEXT
                    // -------- LANGUAGE INDICATOR
                    Container(
                      child: languageName == "English"
                          ? Container()
                          : Container(
                              padding: EdgeInsets.only(top: Styles.spacing, left: 20),
                              child: SelectableText(
                                "$languageName",
                                style: Styles.highlightText,
                              ),
                            ),
                    ),
                    // ------- ACTUAL TEXT
                    SelectableContainer(
                      text: spans,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),

              // --------------- APP BAR
              DghaAppBar(
                text: widget.appBarTitle,
                isMenu: false,
                semanticLabel: widget.appBarTitle,
                childOne: Semantics(
                  button: true,
                  label: "Menu",
                  hint: "Double tap to open side bar menu",
                  child: GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: DghaIcon(
                      icon: FontAwesomeIcons.bars,
                      backgroundColor: Styles.midnightBlue,
                      iconColor: Styles.yellow,
                    ),
                  ),
                ),
                childTwo: Container(
                  child: PopupMenuButton(
                    onSelected: (choice) {
                      final texts = widget.texts;
                      if (texts == null) return;
                      int newLangIndex = texts.indexWhere((lang) => lang.languageName == choice);
                      loadText(newLangIndex);
                    },
                    child: Semantics(
                      button: true,
                      label: "Translate",
                      hint: "Double tap to open translate drop down menu",
                      child: DghaIcon(
                        icon: Icons.translate,
                        backgroundColor: Styles.midnightBlue,
                        iconColor: Styles.yellow,
                      ),
                    ),
                    itemBuilder: (BuildContext ctxt) {
                      return (widget.texts ?? <Language>[]).map((Language lang) {
                        return PopupMenuItem(
                          height: this.popUpHeight,
                          value: lang.languageName,
                          child: Semantics(
                            hint: "Double tap to select ${lang.languageName} translation.",
                            child: Container(
                              child: Text(
                                lang.languageName ?? '',
                                style: Styles.txtBtnStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ],
          );
        },
      )),
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.infoPage),
    );
  }
}
