import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DghaAppBar extends StatelessWidget {
  final Widget? childOne;
  final Widget? childTwo;
  final String? text;
  final bool? isMenu;
  final String? semanticLabel;

  const DghaAppBar(
      {this.childOne,
      this.childTwo,
      this.text,
      this.isMenu,
      this.semanticLabel,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(Styles.normalRadius),
            bottomRight: Radius.circular(Styles.normalRadius),
          ),
          boxShadow: const [
            BoxShadow(color: Styles.grey, blurRadius: 3, offset: Offset(0, 3))
          ]),
      child: Row(
        children: <Widget>[
          childOne ??
              DghaIcon(
                icon: FontAwesomeIcons.bars,
                backgroundColor: Colors.transparent,
                iconColor: Colors.transparent,
              ),
          Expanded(
            child: Semantics(
              label: semanticLabel,
              excludeSemantics: true,
              child: Text(
                text ?? '',
                style: (isMenu ?? false) ? Styles.h1Style : Styles.h2Style,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          childTwo ??
              DghaIcon(
                icon: FontAwesomeIcons.bars,
                backgroundColor: Colors.transparent,
                iconColor: Colors.transparent,
              ),
        ],
      ),
    );
  }
}
