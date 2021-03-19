import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

import '../../templates/dict_array_widget.dart';

class KernelPatchWidget extends StatefulWidget {
  @override
  _KernelPatchWidgetState createState() => _KernelPatchWidgetState();
}

class _KernelPatchWidgetState extends State<KernelPatchWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DictArrayWidget(
            getArray: () => globals.pConfig.getValue(["content", "Kernel", "content", "Patch", "content"], null),
            setArray: (value) => globals.pConfig.setValue(["content", "Kernel", "content", "Patch", "content"], value, null),
            width: 600,
            keyForHeader: "Comment",
            getDummyEntry: () => {
              "Arch": {"type": "string", "content": "Any"},
              "Base": {"type": "string", "content": ""},
              "Comment": {"type": "string", "content": ""},
              "Count": {"type": "integer", "content": "0"},
              "Enabled": {"type": "bool", "content": "0"},
              "Find": {"type": "data", "content": ""},
              "Identifier": {"type": "string", "content": ""},
              "Limit": {"type": "integer", "content": "0"},
              "Mask": {"type": "data", "content": ""},
              "MaxKernel": {"type": "string", "content": ""},
              "MinKernel": {"type": "string", "content": ""},
              "Replace": {"type": "data", "content": ""},
              "ReplaceMask": {"type": "data", "content": ""},
              "Skip": {"type": "integer", "content": "0"},
            },
          ),
        ),
      ],
    );
  }
}
