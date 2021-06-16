import 'package:flutter/cupertino.dart';

import '../../templates/dict_array_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

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
        Expanded(
          child: DictArrayWidget(
            getArray: () => globals.pConfig.getValue(["content", "Misc", "content", "Entries", "content"], null),
            setArray: (value) => globals.pConfig.setValue(["content", "Misc", "content", "Entries", "content"], value, null),
            width: 600,
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
        ),
      ],
    );
  }
}
