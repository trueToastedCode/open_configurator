import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;
import 'package:open_configurator/templates/dict_array_widget.dart';

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
        SizedBox(height: globals.INNER_PADDING),
        DictArrayWidget(
          getArray: () => globals.pConfig.getValue(["content", "Kernel", "content", "Add", "content"], null),
          setArray: (value) => globals.pConfig.setValue(["content", "Kernel", "content", "Add", "content"], value, null),
          width: globals.ITEM_DEFAULT_WIDTH,
          itemHeight: globals.ITEM_DEFAULT_HEIGHT,
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
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
