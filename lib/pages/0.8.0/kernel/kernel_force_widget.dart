import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/templates/dict_array_widget.dart';

class KernelForceWidget extends StatefulWidget {
  @override
  _KernelForceWidgetState createState() => _KernelForceWidgetState();
}

class _KernelForceWidgetState extends State<KernelForceWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        DictArrayWidget(
          getArray: () => globals.pConfig.getValue(["content", "Kernel", "content", "Force", "content"], null),
          setArray: (value) => globals.pConfig.setValue(["content", "Kernel", "content", "Force", "content"], value, null),
          width: globals.ITEM_DEFAULT_WIDTH,
          itemHeight: globals.ITEM_DEFAULT_HEIGHT,
          keyForHeader: "Comment",
          getDummyEntry: () => {
            "Arch": {"type": "string", "content": "Any"},
            "BundlePath": {"type": "string", "content": ""},
            "Comment": {"type": "string", "content": ""},
            "Enabled": {"type": "bool", "content": "0"},
            "ExecutablePath": {"type": "string", "content": ""},
            "Identifier": {"type": "string", "content": ""},
            "MaxKernel": {"type": "string", "content": ""},
            "MinKernel": {"type": "string", "content": ""},
            "PlistPath": {"type": "string", "content": "Contents/Info.plist"},
          },
        ),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
