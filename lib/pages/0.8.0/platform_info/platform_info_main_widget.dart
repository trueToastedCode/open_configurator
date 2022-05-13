import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class PlatformInfoMainWidget extends StatefulWidget {
  @override
  _PlatformInfoMainWidgetState createState() => _PlatformInfoMainWidgetState();
}

class _PlatformInfoMainWidgetState extends State<PlatformInfoMainWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        ...globals.buildWidgetsNoTree(["content", "PlatformInfo", "content"], 0, globals.ITEM_DEFAULT_WIDTH, globals.ITEM_DEFAULT_HEIGHT, ["Generic"]),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
