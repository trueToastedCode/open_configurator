import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/templates/checkbox_widget.dart';
import 'package:open_configurator/templates/dict_array_widget.dart';

class UefiDriversWidget extends StatefulWidget {
  @override
  _UefiDriversWidgetState createState() => _UefiDriversWidgetState();
}

class _UefiDriversWidgetState extends State<UefiDriversWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        CheckboxWidget(
          width: globals.ITEM_DEFAULT_WIDTH,
          height: globals.ITEM_DEFAULT_HEIGHT,
          title: "ConnectDrivers",
          getValue: () => globals.pConfig.getValue(["content", "UEFI", "content", "ConnectDrivers", "content"], null),
          setValue: (value) => globals.pConfig.setValue(["content", "UEFI", "content", "ConnectDrivers", "content"], value, null),
        ),
        SizedBox(height: 5),
        DictArrayWidget(
          getArray: () => globals.pConfig.getValue(["content", "UEFI", "content", "Drivers", "content"], null),
          setArray: (value) => globals.pConfig.setValue(["content", "UEFI", "content", "Drivers", "content"], value, null),
          width: globals.ITEM_DEFAULT_WIDTH,
          itemHeight: globals.ITEM_DEFAULT_HEIGHT,
          keyForHeader: "Comment",
          getDummyEntry: () => {
            "Arguments": {"type": "string", "content": ""},
            "Comment": {"type": "string", "content": ""},
            "Enabled": {"type": "bool", "content": "0"},
            "Path": {"type": "string", "content": ""},
          },
        ),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
