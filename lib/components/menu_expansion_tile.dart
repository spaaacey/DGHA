import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/components/menu_tile.dart';
import 'package:dgha/misc/styles.dart';
import 'package:dgha/models/menu_tile_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuExpansionTile extends StatefulWidget {
  final MenuTileData? tile;

  const MenuExpansionTile({this.tile, super.key});

  @override
  _MenuExpansionTileState createState() => _MenuExpansionTileState();
}

class _MenuExpansionTileState extends State<MenuExpansionTile> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              Semantics(
                excludeSemantics: true,
                child: Row(
                  children: <Widget>[
                    DghaIcon(
                      icon: widget.tile?.icon ?? Icons.info,
                      backgroundColor: Styles.midnightBlue,
                      iconColor: Styles.yellow,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          widget.tile?.title ?? '',
                          style: Styles.txtBtnStyle,
                        ),
                      ),
                    ),
                    Icon(
                      isCollapsed ? FontAwesomeIcons.solidSquareCaretUp : FontAwesomeIcons.squareCaretDown,
                      color: Styles.midnightBlue,
                      size: 30,
                    )
                  ],
                ),
              ),
              ExpansionTile(
                title: Semantics(
                  button: true,
                  hint: isCollapsed ? "Double tap to close menu" : widget.tile?.semanticHint,
                  child: Text(
                    'Laws',
                    style: const TextStyle(color: Styles.transparent),
                  ),
                ),
                onExpansionChanged: (expanded) {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                },
                trailing: const Text(""),
                children: _buildChildren(),
              ),
            ],
          ),
        )
      ],
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = <Widget>[];
    for (int i = 0; i < (widget.tile?.children.length ?? 0); i++) {
      children.add(MenuTile(
        tile: widget.tile!.children[i],
        paddingLeft: 95,
      ));
    }
    return children;
  }
}
