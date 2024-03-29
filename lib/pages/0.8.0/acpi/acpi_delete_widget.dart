import 'package:flutter/cupertino.dart';
import 'package:open_configurator/templates/dict_array_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

class AcpiDeleteWidget extends StatefulWidget {
  @override
  _AcpiDeleteWidgetState createState() => _AcpiDeleteWidgetState();
}

class _AcpiDeleteWidgetState extends State<AcpiDeleteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        DictArrayWidget(
          getArray: () => globals.pConfig.getValue(["content", "ACPI", "content", "Delete", "content"], null),
          setArray: (value) => globals.pConfig.setValue(["content", "ACPI", "content", "Delete", "content"], value, null),
          width: globals.ITEM_DEFAULT_WIDTH,
          itemHeight: globals.ITEM_DEFAULT_HEIGHT,
          keyForHeader: "Comment",
          getDummyEntry: () => {
            "All": {"type": "bool", "content": "0"},
            "Comment": {"type": "string", "content": ""},
            "Enabled": {"type": "bool", "content": "0"},
            "OemTableId": {"type": "data", "content": ""},
            "TableLength": {"type": "integer", "content": "0"},
            "TableSignature": {"type": "data", "content": ""},
          },
        ),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
