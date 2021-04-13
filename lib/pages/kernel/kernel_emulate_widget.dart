import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class KernelEmulateWidget extends StatefulWidget {
  @override
  _KernelEmulateWidgetState createState() => _KernelEmulateWidgetState();
}

class _KernelEmulateWidgetState extends State<KernelEmulateWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "Kernel", "content", "Emulate", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
