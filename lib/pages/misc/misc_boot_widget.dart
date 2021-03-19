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
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "Misc", "content", "Boot", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
