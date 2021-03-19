import 'package:flutter/cupertino.dart';
import 'package:open_configurator/templates/dict_array_widget.dart';
import 'package:open_configurator/globals.dart' as globals;

class UefiReservedMemoryWidget extends StatefulWidget {
  @override
  _UefiReservedMemoryWidgetState createState() => _UefiReservedMemoryWidgetState();
}

class _UefiReservedMemoryWidgetState extends State<UefiReservedMemoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DictArrayWidget(
            getArray: () => globals.pConfig.getValue(["content", "UEFI", "content", "ReservedMemory", "content"], null),
            setArray: (value) => globals.pConfig.setValue(["content", "UEFI", "content", "ReservedMemory", "content"], value, null),
            width: 600,
            keyForHeader: "Comment",
            getDummyEntry: () => {
              "Address": {"type": "integer", "content": "0"},
              "Comment": {"type": "string", "content": ""},
              "Enabled": {"type": "bool", "content": "0"},
              "Size": {"type": "integer", "content": "0"},
              "Type": {"type": "string", "content": ""},
            },
          ),
        ),
      ],
    );
  }
}
