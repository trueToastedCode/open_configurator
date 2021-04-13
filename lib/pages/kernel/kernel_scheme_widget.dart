import 'package:flutter/cupertino.dart';
import 'package:open_configurator/globals.dart' as globals;

class KernelSchemeWidget extends StatefulWidget {
  @override
  _KernelSchemeWidgetState createState() => _KernelSchemeWidgetState();
}

class _KernelSchemeWidgetState extends State<KernelSchemeWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: globals.buildWidgetsNoTree(["content", "Kernel", "content", "Scheme", "content"], 0, 270, -1, null),
        ),
      ],
    );
  }
}
