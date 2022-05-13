import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;

class MiscBootWidget extends StatefulWidget {
  @override
  _MiscBootWidgetState createState() => _MiscBootWidgetState();
}

class _MiscBootWidgetState extends State<MiscBootWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        ...globals.buildWidgetsNoTree(["content", "Misc", "content", "Boot", "content"], 0, globals.ITEM_DEFAULT_WIDTH, globals.ITEM_DEFAULT_HEIGHT, null),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
