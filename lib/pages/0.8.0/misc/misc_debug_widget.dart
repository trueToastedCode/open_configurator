import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;

class MiscDebugWidget extends StatefulWidget {
  @override
  _MiscDebugWidgetState createState() => _MiscDebugWidgetState();
}

class _MiscDebugWidgetState extends State<MiscDebugWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        ...globals.buildWidgetsNoTree(["content", "Misc", "content", "Debug", "content"], 0, globals.ITEM_DEFAULT_WIDTH, globals.ITEM_DEFAULT_HEIGHT, null),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
