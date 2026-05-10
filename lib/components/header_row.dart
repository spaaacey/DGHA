import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';

class HeaderRow extends StatelessWidget {
  final String? text;

  const HeaderRow({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/dgha_logo/logo.png")),
          ),
        ),
        Container(
          child: Text(
            text ?? '',
            style: Styles.h2Style,
          ),
        ),
      ],
    );
  }
}
