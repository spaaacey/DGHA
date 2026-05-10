import 'package:dgha/components/dgha_text_btn.dart';
import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';

class ViewMoreBtn extends StatelessWidget {
  final bool showCondition;
  final bool loadingCondition;
  final Function() onTap;
  final double bottomPadding;

  const ViewMoreBtn({required this.showCondition, required this.loadingCondition, required this.onTap, this.bottomPadding = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if(showCondition) {
          return Container(
            padding: EdgeInsets.only(bottom: this.bottomPadding),
            child: DghaTextButton(
              minWidth: MediaQuery.of(context).size.width * 0.45,
              text: this.loadingCondition ? "Loading . . . " : "View More",
            textStyle: this.loadingCondition ? Styles.blackTxtBtnStyle : Styles.yellowTxtBtnStyle,
            colour: this.loadingCondition ? Colors.grey : Styles.midnightBlue,
              onTap: () {
                this.loadingCondition ? null : this.onTap(); 
              },
            ),
          );
        } else {
          return Container(); 
        }
      },
    );
  }
}
