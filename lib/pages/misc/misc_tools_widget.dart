import 'package:flutter/cupertino.dart';

import '../../templates/dict_array_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

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
        Expanded(
          child: DictArrayWidget(
            getArray: () => globals.pConfig.getValue(["content", "Misc", "content", "Tools", "content"], null),
            setArray: (value) => globals.pConfig.setValue(["content", "Misc", "content", "Tools", "content"], value, null),
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
              "RealPath": {"type": "bool", "content": "0"},
              "TextMode": {"type": "bool", "content": "0"},
            },
          ),
        ),
      ],
    );
  }
}
