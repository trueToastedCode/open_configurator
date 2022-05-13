import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class KernelQuirksWidget extends StatefulWidget {
  @override
  _KernelQuirksWidgetState createState() => _KernelQuirksWidgetState();
}

class _KernelQuirksWidgetState extends State<KernelQuirksWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        ...globals.buildWidgetsNoTree(["content", "Kernel", "content", "Quirks", "content"], 0, globals.ITEM_DEFAULT_WIDTH, globals.ITEM_DEFAULT_HEIGHT, null),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
