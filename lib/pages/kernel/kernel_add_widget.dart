import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

import '../../templates/dict_array_widget.dart';

class KernelAddWidget extends StatefulWidget {
  @override
  _KernelAddWidgetState createState() => _KernelAddWidgetState();
}

class _KernelAddWidgetState extends State<KernelAddWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DictArrayWidget(
            getArray: () => globals.pConfig.getValue(["content", "Kernel", "content", "Add", "content"], null),
            setArray: (value) => globals.pConfig.setValue(["content", "Kernel", "content", "Add", "content"], value, null),
            width: 600,
            keyForHeader: "Comment",
            getDummyEntry: () => {
              "Arch": {"type": "string", "content": "x86_64"},
              "BundlePath": {"type": "string", "content": "*.kext"},
              "Comment": {"type": "string", "content": ""},
              "Enabled": {"type": "bool", "content": "0"},
              "ExecutablePath": {"type": "string", "content": "Contents/MacOS/*"},
              "MaxKernel": {"type": "string", "content": ""},
              "MinKernel": {"type": "string", "content": ""},
              "PlistPath": {"type": "string", "content": "Contents/Info.plist"},
            },
          ),
        ),
      ],
    );
  }
}
