import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';

class YellowTagHighlight extends StatelessWidget {
  final String text; 
  final TextStyle textStyle; 
  final double size;
  final double verticalPadding; 

  const YellowTagHighlight({required this.text, required this.textStyle, this.size = 28, this.verticalPadding = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        // minHeight: 10,
        minWidth: size
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: verticalPadding),
      decoration: BoxDecoration(
      color: Styles.yellow,
      borderRadius: BorderRadius.all(Radius.circular(1000)),
      ),
      child: Text(
        text.toString(),
        style: this.textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}