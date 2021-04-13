import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class KernelQuirksWidget extends StatefulWidget {
  @override
  _KernelQuirksWidgetState createState() => _KernelQuirksWidgetState();
}

class _KernelQuirksWidgetState extends State<KernelQuirksWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "Kernel", "content", "Quirks", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
