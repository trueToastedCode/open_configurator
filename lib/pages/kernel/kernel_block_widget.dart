import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

import '../../templates/dict_array_widget.dart';

class KernelBlockWidget extends StatefulWidget {
  @override
  _KernelBlockWidgetState createState() => _KernelBlockWidgetState();
}

class _KernelBlockWidgetState extends State<KernelBlockWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DictArrayWidget(
            getArray: () => globals.pConfig.getValue(["content", "Kernel", "content", "Block", "content"], null),
            setArray: (value) => globals.pConfig.setValue(["content", "Kernel", "content", "Block", "content"], value, null),
            width: 600,
            keyForHeader: "Comment",
            getDummyEntry: () => {
              "Arch": {"type": "string", "content": "Any"},
              "Comment": {"type": "string", "content": ""},
              "Enabled": {"type": "bool", "content": "0"},
              "Identifier": {"type": "string", "content": ""},
              "MaxKernel": {"type": "string", "content": ""},
              "MinKernel": {"type": "string", "content": ""},
              "Strategy": {"type": "string", "content": "Disable"},
            },
          ),
        ),
      ],
    );
  }
}
