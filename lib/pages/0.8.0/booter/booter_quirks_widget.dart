import 'package:flutter/cupertino.dart';

import 'package:open_configurator/globals.dart' as globals;

class BooterQuirksWidget extends StatefulWidget {
  @override
  _BooterQuirksWidgetState createState() => _BooterQuirksWidgetState();
}

class _BooterQuirksWidgetState extends State<BooterQuirksWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        ...globals.buildWidgetsNoTree(["content", "Booter", "content", "Quirks", "content"], 0, globals.ITEM_DEFAULT_WIDTH, globals.ITEM_DEFAULT_HEIGHT, null),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
