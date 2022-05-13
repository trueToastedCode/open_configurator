import 'package:flutter/cupertino.dart';

import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/templates/dict_array_widget.dart';

class MiscEntriesWidget extends StatefulWidget {
  @override
  _MiscEntriesWidgetState createState() => _MiscEntriesWidgetState();
}

class _MiscEntriesWidgetState extends State<MiscEntriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        DictArrayWidget(
          getArray: () => globals.pConfig.getValue(["content", "Misc", "content", "Entries", "content"], null),
          setArray: (value) => globals.pConfig.setValue(["content", "Misc", "content", "Entries", "content"], value, null),
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
            "TextMode": {"type": "bool", "content": "0"},
          },
        ),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
