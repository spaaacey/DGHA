import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';

class DghaIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final double paddingPadding;
  final double padding;

  const DghaIcon({
    required this.icon,
    this.iconColor = Styles.yellow,
    this.backgroundColor = Styles.midnightBlue,
    this.size = Styles.iconSize,
    this.paddingPadding = Styles.iconPaddingPadding,
    this.padding = Styles.iconPadding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingPadding),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(1000)),
        ),
        child: Icon(
          icon,
          size: size,
          color: iconColor,
        ),
      ),
    );
  }
}
