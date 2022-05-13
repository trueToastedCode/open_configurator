import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class PlatformInfoGenericWidget extends StatefulWidget {
  @override
  _PlatformInfoGenericWidgetState createState() => _PlatformInfoGenericWidgetState();
}

class _PlatformInfoGenericWidgetState extends State<PlatformInfoGenericWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        ...globals.buildWidgetsNoTree(["content", "PlatformInfo", "content", "Generic", "content"], 0, globals.ITEM_DEFAULT_WIDTH, globals.ITEM_DEFAULT_HEIGHT, null),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
