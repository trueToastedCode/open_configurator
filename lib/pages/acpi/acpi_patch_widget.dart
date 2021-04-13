import 'package:flutter/cupertino.dart';
import 'package:open_configurator/templates/dict_array_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

class AcpiPatchWidget extends StatefulWidget {
  @override
  _AcpiPatchWidgetState createState() => _AcpiPatchWidgetState();
}

class _AcpiPatchWidgetState extends State<AcpiPatchWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DictArrayWidget(
            getArray: () => globals.pConfig.getValue(["content", "ACPI", "content", "Patch", "content"], null),
            setArray: (value) => globals.pConfig.setValue(["content", "ACPI", "content", "Patch", "content"], value, null),
            width: 600,
            keyForHeader: "Comment",
            getDummyEntry: () => {
              "Base": {"type": "string", "content": ""},
              "BaseSkip": {"type": "integer", "content": "0"},
              "Comment": {"type": "string", "content": ""},
              "Count": {"type": "integer", "content": "0"},
              "Enabled": {"type": "bool", "content": "0"},
              "Find": {"type": "data", "content": ""},
              "Limit": {"type": "integer", "content": "0"},
              "Mask": {"type": "data", "content": ""},
              "OemTableId": {"type": "data", "content": ""},
              "Replace": {"type": "data", "content": ""},
              "ReplaceMask": {"type": "data", "content": ""},
              "Skip": {"type": "integer", "content": "0"},
              "TableLength": {"type": "integer", "content": "0"},
              "TableSignature": {"type": "data", "content": ""},
            },
          ),
        ),
      ],
    );
  }
}
