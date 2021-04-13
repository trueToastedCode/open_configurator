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
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "Misc", "content", "Debug", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
