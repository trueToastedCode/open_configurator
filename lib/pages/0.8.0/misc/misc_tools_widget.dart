import 'package:flutter/cupertino.dart';

import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/templates/dict_array_widget.dart';

class MiscToolsWidget extends StatefulWidget {
  @override
  _MiscToolsWidgetState createState() => _MiscToolsWidgetState();
}

class _MiscToolsWidgetState extends State<MiscToolsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        DictArrayWidget(
          getArray: () => globals.pConfig.getValue(["content", "Misc", "content", "Tools", "content"], null),
          setArray: (value) => globals.pConfig.setValue(["content", "Misc", "content", "Tools", "content"], value, null),
          width: globals.ITEM_DEFAULT_WIDTH,
          itemHeight: globals.ITEM_DEFAULT_HEIGHT,
          keyForHeader: "Comment",
          getDummyEntry: () => {
            "Arguments": {"type": "string", "content": "0"},
            "Auxiliary": {"type": "bool", "content": "0"},
            "Comment": {"type": "string", "content": ""},
            "Enabled": {"type": "bool", "content": "0"},
            "Flavour": {"type": "string", "content": "Auto"},
            "Name": {"type": "string", "content": ""},
            "Path": {"type": "string", "content": ""},
            "RealPath": {"type": "bool", "content": "0"},
            "TextMode": {"type": "bool", "content": "0"},
          },
        ),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
