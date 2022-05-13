import 'package:flutter/cupertino.dart';

import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/templates/dict_array_widget.dart';

class BooterMmioWhitelistWidget extends StatefulWidget {
  @override
  _BooterMmioWhitelistWidgetState createState() => _BooterMmioWhitelistWidgetState();
}

class _BooterMmioWhitelistWidgetState extends State<BooterMmioWhitelistWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        DictArrayWidget(
          getArray: () => globals.pConfig.getValue(["content", "Booter", "content", "MmioWhitelist", "content"], null),
          setArray: (value) => globals.pConfig.setValue(["content", "Booter", "content", "MmioWhitelist", "content"], value, null),
          width: globals.ITEM_DEFAULT_WIDTH,
          itemHeight: globals.ITEM_DEFAULT_HEIGHT,
          keyForHeader: "Comment",
          getDummyEntry: () => {
            "Address": {"type": "integer", "content": "0"},
            "Comment": {"type": "string", "content": ""},
            "Enabled": {"type": "bool", "content": "0"},
          },
        ),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
