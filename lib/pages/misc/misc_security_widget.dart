import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_configurator/globals.dart' as globals;

class MiscSecurityWidget extends StatefulWidget {
  @override
  _MiscSecurityWidgetState createState() => _MiscSecurityWidgetState();
}

class _MiscSecurityWidgetState extends State<MiscSecurityWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "Misc", "content", "Security", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
