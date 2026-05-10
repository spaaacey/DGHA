import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';

class LoadingText extends StatelessWidget {
  final bool condition;
  const LoadingText({required this.condition, super.key});

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return Center(
        child: Text(
          "Loading . . .",
          style: Styles.h1Style,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
