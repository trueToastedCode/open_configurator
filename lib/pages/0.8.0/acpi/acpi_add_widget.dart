import 'package:flutter/cupertino.dart';
import 'package:open_configurator/templates/dict_array_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

class AcpiAddWidget extends StatefulWidget {
  @override
  _AcpiAddWidgetState createState() => _AcpiAddWidgetState();
}

class _AcpiAddWidgetState extends State<AcpiAddWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        DictArrayWidget(
          getArray: () => globals.pConfig.getValue(["content", "ACPI", "content", "Add", "content"], null),
          setArray: (value) => globals.pConfig.setValue(["content", "ACPI", "content", "Add", "content"], value, null),
          width: globals.ITEM_DEFAULT_WIDTH,
          itemHeight: globals.ITEM_DEFAULT_HEIGHT,
          keyForHeader: "Path",
          getDummyEntry: () => {
            "Comment": {"type": "string", "content": "My SSDT"},
            "Enabled": {"type": "bool", "content": "0"},
            "Path": {"type": "string", "content": "SSDT-*.aml"},
          },
        ),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
