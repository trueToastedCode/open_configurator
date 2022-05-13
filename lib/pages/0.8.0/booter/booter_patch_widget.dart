import 'package:flutter/cupertino.dart';

import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/templates/dict_array_widget.dart';

class BooterPatchWidget extends StatefulWidget {
  @override
  _BooterPatchWidgetState createState() => _BooterPatchWidgetState();
}

class _BooterPatchWidgetState extends State<BooterPatchWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        DictArrayWidget(
          getArray: () => globals.pConfig.getValue(["content", "Booter", "content", "Patch", "content"], null),
          setArray: (value) => globals.pConfig.setValue(["content", "Booter", "content", "Patch", "content"], value, null),
          width: globals.ITEM_DEFAULT_WIDTH,
          itemHeight: globals.ITEM_DEFAULT_HEIGHT,
          keyForHeader: "Comment",
          getDummyEntry: () => {
            "Arch": {"type": "string", "content": ""},
            "Comment": {"type": "string", "content": ""},
            "Count": {"type": "integer", "content": "0"},
            "Enabled": {"type": "bool", "content": "0"},
            "Find": {"type": "data", "content": ""},
            "Identifier": {"type": "string", "content": ""},
            "Limit": {"type": "integer", "content": "0"},
            "Mask": {"type": "data", "content": ""},
            "Replace": {"type": "data", "content": ""},
            "ReplaceMask": {"type": "data", "content": ""},
            "Skip": {"type": "integer", "content": "0"},
          },
        ),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
