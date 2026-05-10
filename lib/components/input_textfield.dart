import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// The widget has to be stateful
// So that the input in the textfield won't be cleared when it is unfocused

class UserInputTextField extends StatefulWidget {
  final IconData? prefixIcon;
  final String? hintText;
  final bool obscureText;
  final bool highlightRed;
  final Function(String)? onChange;
  final TextInputType? keyboardType;
  final bool autoFocus;
  final Function? prefixOnTap;
  final Function(String)? onSubmit;
  final bool changeFocusColour;
  final String textFieldLabel;
  final bool activePrefix;

  const UserInputTextField(
      {this.prefixIcon,
      this.activePrefix = true,
      this.hintText,
      this.obscureText = false,
      this.highlightRed = false,
      this.onChange,
      this.keyboardType,
      this.autoFocus = false,
      this.prefixOnTap,
      this.onSubmit,
      this.textFieldLabel = "",
      this.changeFocusColour = true,
      super.key});

  @override
  _UserInputTextFieldState createState() => _UserInputTextFieldState();
}

class _UserInputTextFieldState extends State<UserInputTextField> {
  final TextEditingController _txtController = new TextEditingController();
  FocusNode focus = new FocusNode();

  Color focusColor = Styles.yellow;
  Color unfocusedColor = Colors.white;

  @override
  void initState() {
    super.initState();
    focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    debugPrint("Focus: " + focus.hasFocus.toString());
  }

  double _getTextFieldWidth() {
    if (widget.prefixIcon != null) {
      return MediaQuery.of(context).size.width - (Styles.spacing * 2) - ((Styles.iconPadding + Styles.iconPaddingPadding + Styles.iconSize) * 3);
    } else {
      return MediaQuery.of(context).size.width - (Styles.spacing * 2) - ((Styles.iconPadding + Styles.iconPaddingPadding + Styles.iconSize) * 2.25);
    }
  }

  Color _setTextFieldColour() {
    Color textfieldColour = Styles.yellow;
    if (widget.changeFocusColour) {
      if (widget.highlightRed) {
        textfieldColour = Styles.red;
      } else {
        textfieldColour = focus.hasFocus ? Styles.yellow : Colors.white;
      }
    }
    return textfieldColour;
  }

  Color _setPrefixColour() {
    Color prefixColour = Styles.midnightBlue;
    if (widget.changeFocusColour) {
      prefixColour = focus.hasFocus ? Styles.midnightBlue : Styles.mediumGrey;
    }
    return prefixColour;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _setTextFieldColour(),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Styles.grey,
            blurRadius: 3,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // -------------------------- NOTE: Prefix Icon
          Builder(
            builder: (context) {
              if (widget.prefixIcon != null) {
                var dghaIcon = DghaIcon(
                  icon: widget.prefixIcon!,
                  iconColor: _setPrefixColour(),
                  backgroundColor: Colors.transparent,
                );
                if (widget.activePrefix) {
                  return Semantics(
                    label: "Back",
                    button: true,
                    hint: "Double tap to go back to Explore Page",
                    child: GestureDetector(
                      onTap: () {
                        widget.prefixOnTap?.call();
                      },
                      child: dghaIcon,
                    ),
                  );
                } else {
                  return dghaIcon;
                }
              }
              return SizedBox(width: 30);
            },
          ),
          // -------------------------- NOTE: Textfield
          Semantics(
            label: "${widget.textFieldLabel}",
            textField: true,
            hint: "Double tap to enter text",
            excludeSemantics: true,
            child: Container(
              width: _getTextFieldWidth(),
              child: TextField(
                keyboardType: widget.keyboardType,
                controller: _txtController,
                focusNode: focus,
                onSubmitted: (value) {
                  widget.onSubmit?.call(value);
                },
                onChanged: (value) {
                  widget.onChange?.call(value);
                },
                style: Styles.pStyle,
                cursorColor: Styles.midnightBlue,
                cursorWidth: 5,
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // -------------------------- NOTE: Suffix Icon
          Semantics(
            excludeSemantics: focus.hasFocus ? false : true,
            child: Container(
              child: Semantics(
                label: "Clear text field",
                hint: "Double tap to clear text field",
                button: true,
                obscured: true,
                child: GestureDetector(
                  onTap: () {
                    if (focus.hasFocus) {
                      Future.delayed(Duration(milliseconds: 50)).then((_) {
                        _txtController.clear();
                      });
                    }
                  },
                  child: Container(
                    child: DghaIcon(
                      icon: FontAwesomeIcons.xmark,
                      iconColor: focus.hasFocus ? Styles.midnightBlue : Colors.transparent,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
