import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class KernelSchemeWidget extends StatefulWidget {
  @override
  _KernelSchemeWidgetState createState() => _KernelSchemeWidgetState();
}

class _KernelSchemeWidgetState extends State<KernelSchemeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: globals.INNER_PADDING),
        ...globals.buildWidgetsNoTree(["content", "Kernel", "content", "Scheme", "content"], 0, globals.ITEM_DEFAULT_WIDTH, globals.ITEM_DEFAULT_HEIGHT, null),
        SizedBox(height: globals.INNER_PADDING),
      ],
    );
  }
}
