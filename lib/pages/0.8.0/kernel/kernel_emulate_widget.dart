import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class KernelEmulateWidget extends StatefulWidget {
  @override
  _KernelEmulateWidgetState createState() => _KernelEmulateWidgetState();
}

class _KernelEmulateWidgetState extends State<KernelEmulateWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        ...globals.buildWidgetsNoTree(["content", "Kernel", "content", "Emulate", "content"], 0, globals.ITEM_DEFAULT_WIDTH, globals.ITEM_DEFAULT_HEIGHT, null),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
