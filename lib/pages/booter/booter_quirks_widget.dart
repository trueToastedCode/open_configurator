import 'package:flutter/cupertino.dart';

import '../../templates/dict_array_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

class BooterQuirksWidget extends StatefulWidget {
  @override
  _BooterQuirksWidgetState createState() => _BooterQuirksWidgetState();
}

class _BooterQuirksWidgetState extends State<BooterQuirksWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "Booter", "content", "Quirks", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
