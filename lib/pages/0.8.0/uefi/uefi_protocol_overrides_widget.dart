import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class UefiProtocolOverridesWidget extends StatefulWidget {
  @override
  _UefiProtocolOverridesWidgetState createState() => _UefiProtocolOverridesWidgetState();
}

class _UefiProtocolOverridesWidgetState extends State<UefiProtocolOverridesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        ...globals.buildWidgetsNoTree(["content", "UEFI", "content", "ProtocolOverrides", "content"], 0, globals.ITEM_DEFAULT_WIDTH, globals.ITEM_DEFAULT_HEIGHT, null),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
