import 'package:flutter/cupertino.dart';

import '../../templates/dict_array_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

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
        Expanded(
          child: DictArrayWidget(
            getArray: () => globals.pConfig.getValue(["content", "Booter", "content", "MmioWhitelist", "content"], null),
            setArray: (value) => globals.pConfig.setValue(["content", "Booter", "content", "MmioWhitelist", "content"], value, null),
            width: 600,
            keyForHeader: "Comment",
            getDummyEntry: () => {
              "Address": {"type": "integer", "content": "0"},
              "Comment": {"type": "string", "content": ""},
              "Enabled": {"type": "bool", "content": "0"},
            },
          ),
        ),
      ],
    );
  }
}
